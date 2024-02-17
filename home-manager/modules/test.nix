{ pkgs, config, lib, inputs, ... }:
with lib;
let 
   cfg = config.teletypeOne.hm.test;
in
{
   options.teletypeOne.hm.test = {
      enable = mkEnableOption "Check if things work, create the test file";
   };
   config = mkIf cfg.enable {
        home.file.".config/test".text = ''
          Hello from the dedicated home-manager test module!
        '';
      };
}
