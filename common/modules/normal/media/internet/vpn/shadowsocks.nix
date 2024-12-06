{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.media.internet.vpn.shadowsocks;
in
{
  options.modules.normal.media.internet.vpn.shadowsocks = {
    enable = mkEnableOption "Enable shadowsocks";
    port = mkOption {
      description = "what port to use. Defaults to.... default port.";
      type = types.int;
      default = 8390;
    };
  };

  config =
    (mkIf cfg.enable {
      services.shadowsocks = {
        enable = true;
        port = cfg.port; # default
        passwordFile = "/root/keys/shadowsocks"; # put something random there and send it to me
        mode = "tcp_and_udp"; # don't forget to open the firewall
        localAddress = ["0.0.0.0"]; # bind addr
      }; # rest should be fine by default
      networking.firewall = {
        allowedUDPPorts = [ cfg.port ];
        allowedTCPPorts = [ cfg.port ];
      };
    }
  );
}
