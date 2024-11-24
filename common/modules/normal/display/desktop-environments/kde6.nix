{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.real.normal.display.desktop-environments.kde6;
in
{
  options.real.normal.display.desktop-environments.kde6 = {
    enable = mkEnableOption "Enable kde6";
  };
  config = {
    services.desktopManager.plasma6.enable = cfg.enable;
  };
}
