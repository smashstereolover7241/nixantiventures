{ pkgs, config, lib, inputs, ... }:
with lib;
let 
   cfg = config.teletypeOne.hm.hyprland;
in
{
   imports = [
	  ./modules
   ];
   options.teletypeOne.hm.hyprland = {
      enable = mkEnableOption "Enable hyprland n shit, just not hyprland itself atm....";
      full = mkOption {
         description = "Change utils to opt-out";
      };
   };
   config = mkIf cfg.enable (mkMerge [
      
       ## do things ?
        (mkIf cfg.full {
           # do other things
	   teletypeOne.hm.hyprland.swayidle.enable = true;
        })
   ]);
}
