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
                };
            };
            default = {};
        };
    };
    config = mkIf cfg.enable (mkMerge [

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

        (mkIf nmdisplay.generic.util.stalonetray {
            real.normal.display.generic.util.stalonetray = true;
        })

        (mkIf nmdisplay.generic.util.dunst {
            real.normal.display.generic.util.dunst = true;
        })

        (mkIf nmdisplay.generic.util.passtrough {
            real.normal.display.generic.util.passthrough = true;
        })

        (mkIf nmdisplay.generic.bars.waybar {
            real.normal.display.generic.bars.waybar = true;
        })

        (mkIf nmdisplay.generic.bars.xmobar {
            real.normal.display.generic.bars.xmobar = true;
        })
    ]);
}
