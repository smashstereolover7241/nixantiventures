{ config, lib, pkgs, ... }:
with lib;
let
  bluetooth-enable = config.hardware.bluetooth.enable;
  cfg = config.teletypeOne.pulseaudio;
in {
  options.teletypeOne.pulseaudio = {
    enable = mkEnableOption "Enable pulseaudio, maybe even with bluetooth support";
  };
  config = mkIf cfg.enable {
    hardware = {
      pulseaudio = {
        enable = true;
        package = mkIf bluetooth-enable pkgs.pulseaudioFull;
      };
      pulseaudio.support32Bit = true;
    };
    systemd.user.services.pulseaudio.enable = true;
  };
}
