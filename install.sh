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
                echo ""
                echo "origin: https://github.com/c4em/dotnix"
                echo ""
                exit 0
                ;;

            "-d" | "--device")
                args_ensure_extra_arg "$@"
                if [ ! -b "$2" ]; then
                    >&2 echo "'$2' is not a valid block device. Make sure you selected the right drive"
                    exit 1
                fi

                DOTNIX_INSTALL_DEVICE="$2"
                shift 2
                ;;

            "-o" | "--host")
                args_ensure_extra_arg "$@"

                if [ ! -f "./hosts/$2" ]; then
                    >&2 echo "Invalid hostname '$2'. Make sure it exists in ./hosts"
                    exit 1
                fi

                DOTNIX_HOSTNAME="$2"
                shift 2
                ;;

            *)
                >&2 echo "Unrecognized argument '$1'. Run with --help to view accepted arguments."
                exit 1
                ;;
        esac
    done

    args_ensure_is_set "--device" "$DOTNIX_INSTALL_DEVICE"
    args_ensure_is_set "--host" "$DOTNIX_HOSTNAME"
}

main () {
    args "$@"
}

set -e
main "$@"

