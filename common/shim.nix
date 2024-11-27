{ lib, config, pkgs, home-manager, ... }@inputs:

with lib;

let
    cfg = config.shim;
    # make things easy to change, less repeat
    cfhm = config.shim.home-manager;
    hmsystem = config.shim.home-manager.system;
    cfnm = config.shim.normal;
    nmsystem = cfnm.system;
    nmdisplay = cfnm.display;
    nmmon = cfnm.monitoring;
    generateStandard = (lib.lists.forEach [ "btop" ]( x:
        (mkIf nmmon.tops.${x}.enable {
            real.normal.monitoring.tops.${x}.enable = true;
        })
    ));
in {
    imports = [./modules];
    #TODO: This is horrible. Find a way to automatically do this....
    options.shim = {
        enable = mkOption {
            description = "Enables the shim or something, why would this be deactivated?";
            type = types.bool;
            default = true;
        };
        home-manager = mkOption {
            description = "all the specific home-manager things";
            type = types.submodule {
                options = {
                    defaults = mkOption {
                        description = "Basic home-manager settings, should be enabled when home-manager is used.";
                        type = types.bool;
                        default = true;
                    };
                    users = mkOption {
                        description = "Users";
                        type = types.submodule {
                            options = {
                                enable = mkOption {
                                    description = "Enable home managed users. Activates system user of same name.";
                                    type = types.bool;
                                    default = false;
                                };
                                name = mkOption {
                                    description = "Username? You only get one tho. Also is group name.";
                                    type = types.str;
                                    default = "localhost";
                                };
                            };
                        };
                        default = {};
                    };
                    cli = mkOption {
                        description = "cli things";
                        type = types.submodule {
                            options = {
                                shell = mkOption {
                                    description = "shell things";
                                    type = types.submodule {
                                        options = {
                                            zsh = mkOption {
                                                description = "zsh specific settings";
                                                type = types.submodule {
                                                    options = {
                                                        enable = mkEnableOption "Enable zsh"; #TODO: Allow for theme disable
                                                        username = mkOption {
                                                            description = "just in case you want to change it...";
                                                            type = types.str;
                                                            default = "localhost";
                                                        };
                                                    };
                                                };
                                                default = {};
                                            };
                                        };
                                    };
                                };
                            };
                        };
                        default = {};
                    };
                    editors = mkOption {
                        description = "editor things";
                        type = types.submodule {
                            options = {
                                emacs = mkOption {
                                    description = "emacs specific settings";
                                    type = types.submodule {
                                        options = {
                                            enable = mkEnableOption "Enable emacs";
                                            username = mkOption {
                                                description = "not because I'm too lazy to just use the default one";
                                                type = types.str;
                                                default = "localhost";
                                            };
                                        };
                                    };
                                    default = {};
                                };
                            };
                        };
                        default = {};
                    };
                };
            };
            default = {};
        };
        normal = mkOption {
            description = "all the \"normal\" things";
            type = types.submodule {
                options = {
                    display = mkOption {
                        description = "Display settings";
                        type = types.submodule {
                            options = {
                                servers = mkOption {
                                    description = "X.Org, wayland";
                                    type = types.submodule {
                                        options = {
                                            xorg = mkOption {
                                                description = "the X window system";
                                                type = types.submodule {
                                                    options = {
                                                        enable = mkEnableOption "Enable the X window system";
                                                    };
                                                };
                                                default = {};
                                            };
                                        };
                                    };
                                    default = {};
                                };
                                drivers = mkOption {
                                    description = "Usually seperate drivers are required for video";
                                    type = types.submodule {
                                        options = {
                                            enable = mkEnableOption "Enable the X window system";
                                            firmware = mkEnableOption "install additional firmware";
                                            rocm = mkEnableOption "install amd rocm (enables firmware)";
                                            gpu = mkOption {
                                                description = "Which gpu?";
                                                type = types.enum ["modesetting" "nvidia" "nouveau" "intel" "amd" "ati" "radeon" "intelAccelerated" "null" "none" ""];
                                                default = "";
                                            };
                                            nvidia = mkOption {
                                                description = "Novideo drivers";
                                                type = types.submodule {
                                                    options = {
                                                        open = mkEnableOption "The open source nvidia drivers";
                                                        prime = mkEnableOption "Nvidia PRIME";
                                                        version = mkOption {
                                                            description = "What version of the drivers to use. Defaults to stable.";
                                                            type = types.str;
                                                            default = "stable";
                                                        };
                                                        intelBusId = mkOption {
                                                            type = types.str;
                                                            default = "PCI:0:2:0";
                                                        };
                                                        nvidiaBusId = mkOption {
                                                            type = types.str;
                                                            default = "PCI:14:0:0";
                                                        };
                                                    };
                                                };
                                            default = {};
                                            };
                                        };
                                    };
                                    default = {};
                                };
                                desktop-environments = mkOption {
                                    description = "DEs (Cinnamon, KDE, XFCE, etc)";
                                    type = types.submodule {
                                        options = {
                                            kde5 = mkOption {
                                                description = "kde5 (legacy)";
                                                type = types.submodule {
                                                    options = {
                                                        enable = mkEnableOption "enable kde5";
                                                        gtk-config = mkEnableOption "use gtk-config for config";
                                                    };
                                                };
                                                default = {};
                                            };
                                            kde6 = mkOption {
                                                description = "kde6";
                                                type = types.submodule {
                                                    options = {
                                                        enable = mkEnableOption "enable kde6";
                                                    };
                                                };
                                                default = {};
                                            };
                                        };
                                    };
                                    default = {};
                                };
                                window-managers = mkOption {
                                    description = "window managers (xmonad, hyprland, etc)";
                                    type = types.submodule {
                                        options = {
                                            xmonad = mkOption {
                                                description = "xmonad";
                                                type = types.submodule {
                                                    options = {
                                                        enable = mkEnableOption "enable xmonad";
                                                    };
                                                };
                                                default = {};
                                            };
                                        };
                                    };
                                    default = {};
                                };
                                login-managers = mkOption {
                                    description = "login managers";
                                    type = types.submodule {
                                        options = {
                                            lightdm = mkOption {
                                                description = "lightdm";
                                                type = types.submodule {
                                                    options = {
                                                        enable = mkEnableOption "enable & install lightdm";
                                                    };
                                                };
                                                default = {};
                                            };
                                            sddm = mkOption {
                                                description = "sddm";
                                                type = types.submodule {
                                                    options = {
                                                        enable = mkEnableOption "enable & install sddm";
                                                        wayland = mkEnableOption "tell it to way the lands";
                                                    };
                                                };
                                                default = {};
                                            };
                                            gtkgreet = mkOption {
                                                description = "gtkgreet";
                                                type = types.submodule {
                                                    options = {
                                                        enable = mkEnableOption "enable & install gtkgreet";
                                                    };
                                                };
                                                default = {};
                                            };
                                        };
                                    };
                                    default = {};
                                };
                                generic = mkOption {
                                    description = "generic things that don't fit elsewhere";
                                    type = types.submodule {
                                        options = {
                                            bars = mkOption {
                                                description = "bars (xmobar, waybar, etc)";
                                                type = types.submodule {
                                                    options = {
                                                        waybar = mkEnableOption "waybar";
                                                        xmobar = mkEnableOption "xmobar";
                                                    };
                                                };
                                                default = {};
                                            };
                                            input = mkOption {
                                                description = "input specific settings";
                                                type = types.submodule {
                                                    options = {
                                                        libinput = mkEnableOption "Enable libinput";
                                                        flatInput = mkEnableOption "Add extra config for non-accelerated mouse input.";
                                                        wacom = mkEnableOption "Install & enable wacom drivers";
                                                    };
                                                };
                                                default = {};
                                            };
                                            util = mkOption {
                                                description = "util settings";
                                                type = types.submodule {
                                                    options = {
                                                        stalonetray = mkEnableOption "Install stalonetray (system tray)";
                                                        dunst = mkEnableOption "Install dunst (notifications)";
                                                        passthrough = mkEnableOption "GPU is passed through, xserver config";
                                                    };
                                                };
                                                default = {};
                                            };
                                        };
                                    };
                                    default = {};
                                };
                                fixes = mkOption {
                                    description = "things never work, so we fix things";
                                    type = types.submodule {
                                        options = {
                                            backlightFix = mkEnableOption "fix backlight, maybe";
                                            wacomFix = mkEnableOption "Fix wacom (X200T)";
                                        };
                                    };
                                    default = {};
                                };
                            };
                        };
                        default = {};
                    };
                    cli = mkOption {
                            description = "cli things";
                            type = types.submodule {
                                options = {
                                    shell = mkOption {
                                        description = "shell things";
                                        type = types.submodule {
                                            options = {
                                                zsh = mkOption {
                                                    description = "zsh specific settings";
                                                    type = types.submodule {
                                                        options = {
                                                            enable = mkEnableOption "Can has zsh";
                                                            ohMy = mkEnableOption "my oh my (zsh)!";
                                                        };
                                                    };
                                                    default = {};
                                                };
                                        };
                                    };
                                };
                            };
                        };
                        default = {};
                    };
                    system = mkOption {
                        description = "all the system specific things";
                        type = types.submodule {
                            options = {
                                users = mkOption {
                                    description = "Users";
                                    type = types.submodule {
                                        options = {
                                            enable = mkOption {
                                                description = "Enable users.";
                                                type = types.bool;
                                                default = true;
                                            };
                                            name = mkOption {
                                                description = "Username? You only get one tho. Also is group name.";
                                                type = types.str;
                                                default = "localhost";
                                            };
                                        };
                                    };
                                    default = {};
                                };
                                flakes = mkOption {
                                    description = "Enable flakes. As this is a flake, it is enabled by default.";
                                    type = types.bool;
                                    default = true;
                                };
                            };
                        };
                        default = {};
                    };
                                                monitoring = mkOption {
                                                    description = "zsh specific settings";
                                                    type = types.submodule {
                                                        options = {
                                                tops = mkOption {
                                                    description = "zsh specific settings";
                                                    type = types.submodule {
                                                        options = {
                                                btop = mkOption {
                                                    description = "zsh specific settings";
                                                    type = types.submodule {
                                                        options = {
                                                            enable = mkEnableOption "Can has zsh";
                                                        };
                                                    };
                                                    default = {};
                                                };
                                                        };
                                                    };
                                                    default = {};
                                                };
                                                        };
                                                    };
                                                    default = {};
                                                };
                };
            };
            default = {};
        };
    };
    config = mkIf cfg.enable (
        (mkMerge [

            (mkMerge generateStandard)

        ####HOME MANAGED MODULES
        (mkIf cfhm.defaults {
             real.home-manager.defaults = true;
        })

        (mkIf cfhm.users.enable {
             shim.normal.system.users.enable = true;
             shim.normal.system.users.name = cfhm.users.name;
             real.home-manager.users.enable = true;
             real.home-manager.users.name = cfhm.users.name;
        })

        (mkIf cfhm.cli.shell.zsh.enable {
             real.home-manager.cli.shell.zsh.enable = true;
             real.home-manager.cli.shell.zsh.username = cfhm.users.name; #TODO: respect the users choice maybe, or remove option
        })

        (mkIf cfhm.editors.emacs.enable {
             real.home-manager.editors.emacs.enable = true;
             real.home-manager.editors.emacs.username = cfhm.users.name; # see zsh
        })

        ####NORMAL MODULES
        (mkIf nmsystem.users.enable {
            real.normal.system.users.enable = true;
            real.normal.system.users.name = nmsystem.users.name;
        })

        (mkIf nmsystem.flakes {
            real.normal.system.flakes.enable = true;
        })

        (mkIf cfnm.cli.shell.zsh.enable (mkMerge [
            {real.normal.cli.shell.zsh.enable = true;}
            (mkIf cfnm.cli.shell.zsh.ohMy{
                real.normal.system.flakes.enable = true;
            })
        ]))

        (mkIf nmdisplay.servers.xorg.enable {
            real.normal.display.servers.xorg.enable = true;
        })

        (mkIf nmdisplay.drivers.enable (mkMerge [
            (mkIf nmdisplay.drivers.rocm {
                real.normal.display.drivers.firmware = true;
                real.normal.display.drivers.rocm = true;
            })
            {
                real.normal.display.drivers.enable = true;
                real.normal.display.drivers.gpu = nmdisplay.drivers.gpu;
                real.normal.display.drivers.firmware = mkDefault nmdisplay.drivers.firmware;

                real.normal.display.drivers.nvidia = {
                    open = nmdisplay.drivers.nvidia.open;
                    prime = nmdisplay.drivers.nvidia.prime;
                    version = nmdisplay.drivers.nvidia.version;
                    intelBusId = nmdisplay.drivers.nvidia.intelBusId;
                    nvidiaBusId = nmdisplay.drivers.nvidia.nvidiaBusId;
                };
            }
        ]))

        (mkIf nmdisplay.desktop-environments.kde5.enable (mkMerge [
            {real.normal.display.desktop-environments.kde5.enable = true;}
            (mkIf nmdisplay.desktop-environments.kde5.gtk-config {
                real.normal.display.desktop-environments.kde5.gtk-config = true;
            })
        ]))

        (mkIf nmdisplay.desktop-environments.kde6.enable {
            real.normal.display.desktop-environments.kde6.enable = true;
        })

        (mkIf nmdisplay.window-managers.xmonad.enable {
            real.normal.display.window-managers.xmonad.enable = true;
        })

        (mkIf nmdisplay.login-managers.lightdm.enable {
            real.normal.display.login-managers.lightdm.enable = true;
            real.normal.display.servers.xorg.enable = true;
        })

        (mkIf nmdisplay.login-managers.sddm.enable {
            real.normal.display.login-managers.sddm.enable = true;
            real.normal.display.login-managers.sddm.wayland = nmdisplay.login-managers.sddm.wayland;
        })

        (mkIf nmdisplay.login-managers.gtkgreet.enable {
            real.normal.display.login-managers.gtkgreet.enable = true;
        })

        (mkIf nmdisplay.generic.util.stalonetray {
            real.normal.display.generic.util.stalonetray = true;
        })

        (mkIf nmdisplay.generic.util.dunst {
            real.normal.display.generic.util.dunst = true;
        })

        (mkIf nmdisplay.generic.util.passthrough {
            real.normal.display.generic.util.passthrough = true;
        })

        (mkIf nmdisplay.generic.bars.waybar {
            real.normal.display.generic.bars.waybar = true;
        })

        (mkIf nmdisplay.generic.bars.xmobar {
            real.normal.display.generic.bars.xmobar = true;
        })

        (mkIf nmdisplay.generic.input.libinput {
            real.normal.display.generic.input.libinput = true;
        })

        (mkIf nmdisplay.generic.input.flatInput {
            real.normal.display.generic.input.flatInput = true;
        })

        (mkIf nmdisplay.generic.input.wacom {
            real.normal.display.generic.input.wacom = true;
        })

        (mkIf nmdisplay.fixes.backlightFix {
            real.normal.display.fixes.backlightFix = true;
        })

        (mkIf nmdisplay.fixes.wacomFix {
            real.normal.display.fixes.wacomFix = true;
        })

        ]));
}
