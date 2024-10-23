{ lib, config, pkgs, home-manager, ... }@inputs:

with lib;

let
    cfg = config.shim;
    # make things easy to change, less repeat
    cfhm = config.shim.home-manager;
    cfnm = config.shim.normal;
    system = cfnm.system;
in {
imports = [./modules];
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
                };
            };
            default = {};
        };
        normal = mkOption {
            description = "all the \"normal\" things";
            type = types.submodule {
                options = {
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
        (mkIf cfhm.users.enable {
            shim.normal.system.users.enable = true;
            shim.normal.system.users.name = cfhm.users.name;
            real.home-manager.users.enable = true;
            real.home-manager.users.name = cfhm.users.name;
        })

        ####NORMAL MODULES
        (mkIf system.users.enable {
            real.normal.system.users.enable = true;
            real.normal.system.users.name = system.users.name;
        })

        (mkIf system.flakes {
            real.normal.system.flakes.enable = true;
        })
    ]);
}
