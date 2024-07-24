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
   services.openssh.settings.PasswordAuthentication = false;
   services.openssh.ports = [ 1529 ];
  });

}
