{ lib, config, pkgs, home-manager, ... }:

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
                        description = "Enable hm users. For now just yes or no.";
                        type = types.bool;
                        default = false;
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
                        description = "all the specific home-manager things";
                        type = types.submodule {
                            options = {
                                users = mkOption {
                                    description = "Enable normal users. For now just yes or no.";
                                    type = types.bool;
                                    default = true;
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
        (mkIf cfhm.users {
            real.normal.system.users.enable = true;
            real.home-manager.users.enable = true;
        })

        ####NORMAL MODULES
        (mkIf system.users {
            real.normal.system.users.enable = true;
        })

        (mkIf system.flakes {
            real.normal.system.flakes.enable = true;
        })
    ]);
}
