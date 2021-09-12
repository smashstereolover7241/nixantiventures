{ config, lib, pkgs, ... }:
with lib;
let
  bluetooth-enable = config.hardware.bluetooth.enable;
  cfg = config.teletypeOne.pipewire;
in {
  options.teletypeOne.pipewire = {
    enable = mkEnableOption "Enable pipewire, maybe even with bluetooth support";
  };
  config = mkIf cfg.enable {
    sound.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [ pulseaudio cadence helvum];
  };
}
