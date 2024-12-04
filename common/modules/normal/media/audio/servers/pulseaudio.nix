{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.media.audio.servers.pulseaudio;
in
{
  options.modules.normal.media.audio.servers.pulseaudio = {
    enable = mkEnableOption "Enable pulseaudio";
    bluetooth = mkEnableOption "Enable pulseaudio blutooth";
  };

  config = mkIf cfg.enable {
    hardware = {
      pulseaudio = {
        enable = true;
        package = mkIf cfg.bluetooth pkgs.pulseaudioFull;
      };
      pulseaudio.support32Bit = true;
    };
    systemd.user.services.pulseaudio.enable = cfg.bluetooth;
    services.pipewire.enable = false; #idk it's enabled otherwise, kinda weird
  };
}
