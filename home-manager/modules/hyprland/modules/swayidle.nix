{ pkgs, config, lib, inputs, ... }:
with lib;
let 
   cfg = config.teletypeOne.hm.hyprland.swayidle;
in
{
   options.teletypeOne.hm.hyprland.swayidle = {
      enable = mkEnableOption "Enable swayidle";
   };
   config = mkIf cfg.enable {
     home.packages = with pkgs; [ swayidle ]; 
     home.file.".config/swayidle/config".text = ''
        timeout 360 'light -O && light -S 5%' resume 'light -I' 
        timeout 720 'swaylock'
        timeout 1000 'light -O && light -S 1%' resume 'light -I'
        timeout 1800 'systemctl suspend'
        before-sleep 'swaylock'
     '';
   };
}
