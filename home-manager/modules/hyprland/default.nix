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
   };
   config = mkIf cfg.enable {
      
   };
}
