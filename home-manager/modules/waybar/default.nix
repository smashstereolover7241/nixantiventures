{ pkgs, config, lib, ... }:
with lib;
let 
   cfg = config.teletypeOne.hm.waybar;
in
{
   options.teletypeOne.hm.waybar = {
      enable = mkEnableOption "Do nothing, just yet :)";
   };
   config = mkIf cfg.enable {
      home.file = {
         ".config/test.txt".source = ./test.txt;
      };
   };
}
