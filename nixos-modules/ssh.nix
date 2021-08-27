{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.ssh;
in {
  options.teletypeOne.ssh = {
    enable = mkEnableOption "Enable ssh";
  };

  config = (mkIf (cfg.enabled) {
   services.sshd.enable = true;
  });

}
