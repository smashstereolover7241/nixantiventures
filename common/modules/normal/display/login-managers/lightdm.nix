{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.real.normal.display.login-managers.lightdm;
in
{
  options.real.normal.display.login-managers.lightdm = {
    enable = mkEnableOption "Install & enable lightdm";
  };

  config = (mkMerge [
     { services.xserver.displayManager.lightdm.enable = mkIf cfg.enable true; }
  ]);
}
