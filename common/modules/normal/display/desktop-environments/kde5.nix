{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.desktop-environments.kde5;
in
{
  options.modules.normal.display.desktop-environments.kde5 = {
    enable = mkEnableOption "Enable kde5";
    gtk-config = mkEnableOption "Enable config";
  };
  config = (mkMerge [
    {
    services.xserver.desktopManager.plasma5.enable = cfg.enable;
    }

    (mkIf cfg.gtk-config {
      environment.systemPackages = (with pkgs; [kde-gtk-config]);
    })
  ]);

}
