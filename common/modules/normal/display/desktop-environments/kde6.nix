{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.desktop-environments.kde6;
in
{
  options.modules.normal.display.desktop-environments.kde6 = {
    enable = mkEnableOption "Enable kde6";
  };
  config = {
    services.desktopManager.plasma6.enable = cfg.enable;
  };
}
