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
     home.file.".config/hypr/hyprpaper.conf".text = ''
        preload = ~/papers/a.png
        #if more than one preload is desired then continue to preload other backgrounds
        # .. more preloads

        #set the default wallpaper(s) seen on initial workspace(s) --depending on the number of monitors used
        wallpaper = ,~/papers/a.png
        #if more than one monitor in use, can load a 2nd image
        #wallpaper = monitor2,/path/to/next_image.png
        # .. more monitors

        #disable splash text rendering over the wallpaper
        splash = false

        #fully disable ipc
        ipc = off
    '';
   };
}
