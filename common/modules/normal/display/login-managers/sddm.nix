{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.login-managers.sddm;
in
{
  options.modules.normal.display.login-managers.sddm = {
    enable = mkEnableOption "Install & enable sddm";
    wayland = mkEnableOption "Tell it to way the lands";
  };

  config = (mkMerge [
     { services.displayManager.sddm.enable = cfg.enable; }
     { services.displayManager.sddm.wayland.enable = cfg.wayland; }
  ]);
}
