{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.real.normal.display.login-managers.sddm;
in
{
  options.real.normal.display.login-managers.sddm = {
    enable = mkEnableOption "Install & enable sddm";
  };

  config = (mkMerge [
     { services.xserver.displayManager.sddm.enable = mkIf cfg.enable true; }
  ]);
}
