{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.servers.xorg.utilities.xkill ;
in
{
  options.modules.normal.display.servers.xorg.utilities.xkill = {
    enable = mkEnableOption "Enable xwininfo";
  };
  config = (mkMerge [
    (mkIf cfg.enable {
        environment.systemPackages = with pkgs; [xorg.xkill];
    })
  ]);
}
