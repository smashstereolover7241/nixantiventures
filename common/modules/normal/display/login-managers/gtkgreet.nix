{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.login-managers.gtkgreet;
  swayConfig = pkgs.writeText "greetd-sway-config" ''
  # `-l` activates layer-shell mode. Notice that `swaymsg exit` will run after gtkgreet.
  exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet;"
  '';
in
{
  options.modules.normal.display.login-managers.gtkgreet = {
    enable = mkEnableOption "Install & enable gtkgreet";
  };

  config = (mkMerge [
     {
       services.greetd = mkIf cfg.enable {
          enable = true;
          settings = {
            default_session = {
              command = "${pkgs.sway}/bin/sway --config ${swayConfig} --unsupported-gpu";
            };
          };
       };
         #TODO: Make this configurable
      environment.etc = mkIf cfg.enable{
        "greetd/environments".text = ''
            Hyprland
            zsh
        '';
      };
     }
  ]);
}
