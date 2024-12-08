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
      environment.systemPackages = with pkgs; [ openssl ]; #TODO: Move this outta here
      services.shadowsocks = {
        enable = true;
        port = cfg.port; # default
        passwordFile = "/root/keys/shadowsocks";
        mode = "tcp_and_udp"; # don't forget to open the firewall
        localAddress = ["0.0.0.0"]; # bind addr
      };
      networking.firewall = {
        allowedUDPPorts = [ cfg.port ];
        allowedTCPPorts = [ cfg.port 80 443 ];
      };
    }
  );
}
