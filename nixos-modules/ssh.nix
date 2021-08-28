{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.ssh;
in {
  options.teletypeOne.ssh = {
    enable = mkEnableOption "Enable ssh";
  };

  config = (mkIf (cfg.enable) {
   services.sshd.enable = true;
   services.openssh.passwordAuthentication = false;
   services.openssh.ports = [ 22 21 ]
  });

}
