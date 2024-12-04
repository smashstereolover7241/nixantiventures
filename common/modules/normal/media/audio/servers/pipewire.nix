{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.media.audio.servers.pipewire;
in
{
  options.modules.normal.media.audio.servers.pipewire = {
    enable = mkEnableOption "Enable pipewire";
  };
  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
