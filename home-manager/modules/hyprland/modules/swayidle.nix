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
   };
}
