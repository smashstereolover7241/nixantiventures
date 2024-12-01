{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.media.audio.music.mpd;
in
{
  options.modules.normal.media.audio.music.mpd = {
    enable = mkEnableOption "Enable mpd";
  };
  config = mkIf cfg.enable {
      services.mpd = {
        enable = true;
        musicDirectory = "/home/localhost/Music";
        user = "localhost";
        extraConfig = ''
          audio_output {
            type "pipewire"
            name "PipeWire alla"
          }
        '';
      };
      systemd.services.mpd.environment.XDG_RUNTIME_DIR = "/run/user/1000";
      environment.systemPackages = with pkgs; [mpd];
  };
}
