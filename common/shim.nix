
{ lib, config, pkgs, home-manager, ... }:

with lib;

let cfg = config.shim;
in {
  imports = [./test.nix];
  options.shim.enable = mkEnableOption "Enables the shim or something, why would this be useful?";
  options.shim.homeTest = mkEnableOption "Enables the shim or something, why would this be useful?";
  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.enable {
        shim.test.enable = true;
    })
  ]);
}
