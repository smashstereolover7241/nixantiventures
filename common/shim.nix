{ lib, config, pkgs, home-manager, ... }:

with lib;

let cfg = config.shim;
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
        flakes = mkOption {
            description = "Enable flakes. As this is a flake, it is enabled by default.";
            type = types.bool;
            default = true;
        };
        users = mkOption {
            description = "Enable users. For now just yes or no.";
            type = types.bool;
            default = true;
        };
        # TODO: make hm and normal submols
    };
    config = mkIf cfg.enable (mkMerge [
        (mkIf cfg.users {
            real.normal.system.users.enable = true;
        })
        (mkIf cfg.home-manager.users {
            real.normal.system.users.enable = true;
            real.home-manager.users.enable = true;
        })
    ]);
}
