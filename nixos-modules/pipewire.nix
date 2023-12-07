{ config, lib, pkgs, ... }:
with lib;
let
  bluetooth-enable = config.hardware.bluetooth.enable;
  cfg = config.teletypeOne.pipewire;
in {
  options.teletypeOne.pipewire = {
    enable = mkEnableOption "Enable pipewire, maybe even with bluetooth support";
    easyeffects = mkEnableOption "Add easyeffects";
  };
  config = (mkMerge [

    (mkIf cfg.enable {
      sound.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

    })

    (mkIf cfg.easyeffects {
      environment.systemPackages = with pkgs; [easyeffects];
    })

  ]);
}
