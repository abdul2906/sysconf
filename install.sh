#!/usr/bin/env sh

# Author: caem - https://caem.dev

# install.sh - Installation script for my NixOS configuration
#
# This script aims to automate the deployment of my configuration
# on a new machine. 

args_ensure_extra_arg() {
    if [ -z "$2" ] || [ "$(echo "$2" | cut -c 1-1)" = "-" ]; then
        >&2 echo "Argument '$1' requires an extra argument. Run --help for more info."
        exit 1
    fi
}

args_ensure_is_set() {
    if [ -z "$2" ]; then
        >&2 echo "Argument '$1' is required to be set. Please consult the README or run again with --help."
        exit 1
    fi
}

args() {
    while [ -n "$1" ]; do
        case "$1" in
            "-h" | "--help")
                echo ""
                echo "$0 - Installation script for my NixOS configuration"
                echo ""
                echo "arguments:"
                echo "  -h|--help                           Print this and exit"
                echo "  -d|--device [device]    (required)  The device you want to install NixOS on to"
                echo "  -o|--host   [hostname]  (required)  The host from ./hosts you want to install"
                echo "  -b|--build                          Build the system without installing"
                echo ""
                echo "origin: https://github.com/c4em/caenix"
                echo ""
                exit 0
                ;;

            "-d" | "--device")
                args_ensure_extra_arg "$@"
                if [ ! -b "$2" ]; then
                    >&2 echo "'$2' is not a valid block device. Make sure you selected the right drive"
                    exit 1
                fi

                CAENIX_INSTALL_DEVICE="$2"
                shift 2
                ;;

            "-o" | "--host")
                args_ensure_extra_arg "$@"

                if [ ! -d "./hosts/$2" ]; then
                    >&2 echo "Invalid hostname '$2'. Make sure it exists in ./hosts"
                    exit 1
                fi

                CAENIX_HOSTNAME="$2"
                shift 2
                ;;
            "-b" | "--build")
                CAENIX_DO_ONLY_BUILD=1
                shift 1
                ;;
            *)
                >&2 echo "Unrecognized argument '$1'. Run with --help to view accepted arguments."
                exit 1
                ;;
        esac
    done

    args_ensure_is_set "--host" "$CAENIX_HOSTNAME"
    if [ -z "$CAENIX_DO_ONLY_BUILD" ]; then
        args_ensure_is_set "--device" "$CAENIX_INSTALL_DEVICE"
    fi
}

sed_safe () {
    # I got this off of some random StackOverflow answer. Don't put too much trust in this.
    printf "%s" "$1" | sed -r 's/([\$\.\*\/\[\\^])/\\\1/g' | sed 's/[]]/\[]]/g'
}

update_managed_values() {
    sed -i 's/\( *device = \)".*"\(; # [managed by install\.sh].*\)/\1"'"$(sed_safe "$CAENIX_INSTALL_DEVICE")"'"\2/' "./hosts/$CAENIX_HOSTNAME/default.nix"
    sed -i 's/\( *device = \)".*"\(; #.*\)/\1"'"$(sed_safe "$CAENIX_INSTALL_DEVICE")"'"\2/' "./hosts/$CAENIX_HOSTNAME/disko.nix"
    sed -i 's/\( *system.stateVersion = \)".*"\(; #.*\)/\1"'"$(sed_safe "$(nixos-version | cut -f1,2 -d '.')")"'"\2/' "./hosts/$CAENIX_HOSTNAME/default.nix"
}

build() {
    nix build ".#nixosConfigurations.${CAENIX_HOSTNAME}.config.system.build.toplevel"
}

permissions() {
    if [ "$(id -u)" = "0" ]; then
        sudo () {
            true
        }
    else
        sudo -v
    fi
}

ensure_confirmation() {
    printf "\e[1;31m=== ARE YOU SURE YOU WANT TO CONTINUE WITH THE INSTALLATION ===\e[0m\n\n"
    printf "This will \e[1;31mIRREVERSIBLY\e[0m wipe all data in '%s'\n" "$CAENIX_INSTALL_DEVICE"
    printf "This disk contains following partitions:\n\n"
    lsblk -o NAME,SIZE,TYPE,FSTYPE "$CAENIX_INSTALL_DEVICE"
    printf "\n"
    lsblk -no NAME "$CAENIX_INSTALL_DEVICE" | tail -n +2 | tr -cd '[:alnum:][:space:]' | xargs -I {} -- df -h "/dev/{}"
    printf "\n"

    printf "Please write 'Yes, do as I say!' to continue with the installation\n> "
    read -r install_prompt
    if [ "$install_prompt" != "Yes, do as I say!" ]; then
        echo "Cancelling installation"
        exit 0
    else
        CAENIX_CONFIRM_DISK_NUKE="yes"
    fi
}

partition_disk() {
    if [ "$CAENIX_CONFIRM_DISK_NUKE" = "yes" ]; then
        sudo nix --experimental-features 'flakes nix-command' run github:nix-community/disko/latest -- \
            --mode destroy,format,mount --yes-wipe-all-disks "./hosts/$CAENIX_HOSTNAME/disko.nix"
    else
        >&2 echo "Aborted installation due to invalid state in the partitioning step."
        exit 1
    fi
}

install() {
    yes | sudo nixos-install --no-root-passwd --flake ".#$CAENIX_HOSTNAME"
}

copy_files_to_new_install() {
    username="$(grep user ./flake.nix | sed -e 's/.*user = "\(.*\)";.*/\1/')"
    if [ -z "$username" ]; then
        >&2 echo "Cannot determine username"
        exit 1
    fi

    sudo cp -vr . /mnt/nix/config
    sudo mkdir -p "/mnt/nix/persist/home/$username/programming/personal"
    sudo ln -svf /nix/config "/mnt/nix/persist/home/$username/programming/personal/caenix"
    sudo chown -R 1000:100 "/mnt/nix/persist/home/$username"
    sudo chown -R 1000:100 "/mnt/nix/config"
}

reboot_on_consent() {
    printf "\n\nInstallation finished. Would you like to reboot?\n[y/n] > "
    read -r do_reboot
    if [ "$do_reboot" = "y" ] || [ "$do_reboot" = "Y" ]; then
        sudo reboot
    fi
}

main () {
    args "$@"
    permissions

    if [ -n "$CAENIX_DO_ONLY_BUILD" ]; then
        if [ -n "$CAENIX_INSTALL_DEVICE" ]; then
            update_managed_values
        fi

        build
        exit 0
    fi

    ensure_confirmation
    update_managed_values
    partition_disk
    copy_files_to_new_install
    install
    reboot_on_consent
}

set -e
main "$@"

