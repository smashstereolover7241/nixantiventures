{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.security.betterlockscreen;
in
{
  options.modules.normal.system.security.betterlockscreen = {
    enable = mkEnableOption "Enable betterlockscreen";
  };
  config = {
    environment.systemPackages = with pkgs; [ betterlockscreen ];
    programs.xss-lock.enable = true;
    programs.xss-lock.lockerCommand = "${pkgs.betterlockscreen}/bin/betterlockscreen -l blur";
  };
}

