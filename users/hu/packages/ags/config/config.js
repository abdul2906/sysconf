import { Bar } from "./bar.js";
import { NotificationPopups } from "./vendor/notificationPopups.js";

App.addIcons(`${App.configDir}/assets`);
App.config({
    style: "./style.css",
    windows: [
        Bar(),
        NotificationPopups(),
    ],
});

