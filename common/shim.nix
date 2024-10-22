{ lib, config, pkgs, home-manager, ... }:

with lib;

let cfg = config.shim;
in {
  imports = [./test.nix ./modules];
  options.shim.enable = mkEnableOption "Enables the shim or something, why would this be deactivated?";
  options.shim.homeTest = mkEnableOption "test me!";
  options.shim.boolTest = mkOption {
    description = "Yes or no.";
        type = types.bool;
            default = true;
  };
    options.shim = {
        flakes = mkOption {
            description = "Enable flakes. As this is a flake, it is enabled by default.";
            type = types.bool;
            default = true;
        };
        userss = mkOption {
            description = "Enable users. For now just yes or no.";
            type = types.bool;
            default = true;
        };
    };
  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.boolTest {
        shim.test.enable = false;
    })
    (mkIf cfg.userss {
        real.enable = true;
#         shim.userss.enable = true;
#        normals.system.userss = true;
    })
  ]);
}
