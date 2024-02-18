{ pkgs, config, lib, inputs, ... }:
with lib;
let 
   cfg = config.teletypeOne.hm.zsh;
in
{
   options.teletypeOne.hm.zsh = {
      enable = mkEnableOption "Enable managed zsh"; 
   };
   config = mkIf cfg.enable (mkMerge [
      {
         programs.zsh.enable = true;
      }
   ]);
}
