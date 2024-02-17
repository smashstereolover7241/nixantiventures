{ pkgs, config, lib, inputs, ... }:
with lib;
let 
   cfg = config.teletypeOne.hm.hyprland.hyprpaper;
#   hyprpaper-pkg = inputs.hyprpaper.packages.${pkgs.hostPlatform.system}.hyprpaper;
in
{
   options.teletypeOne.hm.hyprland.hyprpaper = {
      enable = mkEnableOption "Enable hyprpaper";
   };
   config = mkIf cfg.enable {
     home.packages = with pkgs; [ hyprpaper ]; 
   };
}
