{ lib, config, pkgs, home-manager, ... }:

with lib;

let cfg = config.shim;
in {
imports = [./modules];
    options.shim = {
        enable = mkEnableOption "Enables the shim or something, why would this be deactivated?";
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
        hmusers = mkOption {
            description = "Enable hm users. For now just yes or no.";
            type = types.bool;
            default = false;
        };
    };
    config = mkIf cfg.enable (mkMerge [
        (mkIf cfg.users {
            real.normal.system.users.enable = true;
        })
        (mkIf cfg.hmusers {
            real.normal.system.users.enable = true;
            real.home-manager.users.enable = true;
        })
    ]);
}
