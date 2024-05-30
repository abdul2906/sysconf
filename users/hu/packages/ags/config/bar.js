const hyprland = await Service.import("hyprland");
const audio = await Service.import("audio");

import { Media } from "./vendor/Media.js";

const VolumeWidget = (properties) => {
    return Widget.Box({
        class_name: "app-volume",
        children: [
            Widget.Box({
                class_name: "app-mixer",
                vertical: true,
                hexpand: true,
                children: [
                    Widget.Label({
                        class_name: "app-mixer-label",
                        label: properties.description,
                        truncate: "end",
                        maxWidthChars: 60,
                        wrap: false,
                        justification: "left",
                    }),
                    Widget.Box({
                        class_name: "app-volume-slider",
                        children: [
                            Widget.Icon({
                                class_name: "volume-icon",
                                icon: "audio-volume-high-symbolic",
                            }),
                            Widget.Slider({
                                hexpand: true,
                                draw_value: false,
                                on_change: ({ value }) => properties.volume = value,
                                setup: self => self.hook(properties, () => {
                                    self.value = properties.volume || 0
                                }),
                            }),
                        ],
                    }),
                    // Widget.Label(properties.stream.name),
                ],
            }),
        ],
    });
};

const VolumeWidgets = () => {
    if (!audio || !audio.apps) {
        return [];
    }

    let widgets = [];
    for (let i = 0; i < audio.apps.length; i++) {
        widgets.push(VolumeWidget(audio.apps[i]));
    }

    return widgets;
};

const Qsd = () => Widget.Box({
    name: "qsd",
    class_name: "qsd",
    vpack: "start",
    vertical: true,
    children: [
        Widget.Box({
            name: "qsd-power",
            class_name: "qsd-power",
            hpack: "end",
            children: [
                Widget.Button({
                    child: Widget.Icon({
                        icon: "system-reboot-symbolic"
                    }),
                }),
                Widget.Button({
                    on_clicked: () => {
                        console.log(audio.apps)
                    },
                    child: Widget.Icon({
                        icon: "system-shutdown-symbolic"
                    }),
                }),
            ],
        }),
        Widget.Box({
            name: "qsd-volume-mixer",
            class_name: "qsd-volume-mixer",
            children: [
                Widget.Box({
                    class_name: "qsd-volume-slider-container",
                    vertical: true,
                    vpack: "start",
                }).hook(audio, self => {
                    self.children = [
                        Widget.Box({
                            class_name: "master-volume",
                            children: [
                                Widget.Icon({
                                    class_name: "volume-icon",
                                    icon: "audio-volume-high-symbolic",
                                }),
                                Widget.Label("master"),
                                Widget.Slider({
                                    hexpand: true,
                                    draw_value: false,
                                    on_change: ({ value }) => audio.speaker.volume = value,
                                    setup: self => self.hook(audio.speaker, () => {
                                        self.value = audio.speaker.volume || 0
                                    }),
                                }),
                            ]
                        })
                    ].concat(VolumeWidgets());
                }),
            ],
        }),
        Media(),
    ],
});

const Menu = () => {
    return Widget.Window({
        name: "shell-menu",
        class_name: "shell-menu",
        exclusivity: "normal",
        anchor: ["top", "right"],
        margins: [5, 5],
        // keymode: "on-demand",
        layer: "top",
        monitor: 0,
        child: Qsd(),
    });
}

App.addWindow(Menu());
App.toggleWindow("shell-menu");

const MenuButton = () => {
    return Widget.Button({
        on_clicked: () => App.toggleWindow("shell-menu"),
        child: Widget.Icon({
            icon: "nixos"
        }),
        class_name: "menu_button",
    });
}

const data = Variable("", {
    poll: [1000, 'date "+%H:%M:%S"'],
});

const Clock = () => {
    return Widget.Label({
        class_name: "clock",
        label: data.bind(),
    });
}

const End = () => {
    return Widget.Box({
        hpack: "end",
        spacing: 8,
        children: [
            Clock(),
            MenuButton(),
        ],
    });
}

const Workspaces = () => {
    const activeId = hyprland.active.workspace.bind("id");
    const workspaces = hyprland.bind("workspaces")
        .as((ws) =>
            ws.sort((a, b) => a.id - b.id).map(({ id }) => Widget.Button({
                on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
                child: Widget.Label(`${id}`),
                class_name: activeId.as((i) => `${i === id ? "focused" : ""}`),
            })
        )
    );

    return Widget.Box({
        class_name: "workspaces",
        children: workspaces,
    });
}

const Start = () => {
    return Widget.Box({
        children: [
            Workspaces(),
        ],
    });
}

export const Bar = () => {
    return Widget.Window({
        name: "bar",
        class_name: "bar",
        monitor: 0,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            start_widget: Start(),
            end_widget: End(),
        }),
    });
}

