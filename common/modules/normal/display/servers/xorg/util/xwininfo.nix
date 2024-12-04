{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.servers.xorg.util.xwininfo;
in
{
  options.modules.normal.display.servers.xorg.util.xwininfo = {
    enable = mkEnableOption "Enable xwininfo";
  };
  config = (mkMerge [
    (mkIf cfg.enable {
        environment.systemPackages = with pkgs; [xorg.xwininfo];
    })
  ]);
}
