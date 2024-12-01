{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.login-managers.lightdm;
in
{
  options.modules.normal.display.login-managers.lightdm = {
    enable = mkEnableOption "Install & enable lightdm";
  };

  config = (mkMerge [
     { services.xserver.displayManager.lightdm.enable = cfg.enable; }
  ]);
}
