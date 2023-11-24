{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.wireguard;
in {
  options.teletypeOne.wireguard = {
    enable = mkEnableOption "Install and enable the wireguard link";
  };

  config = (mkMerge [
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ wireguard-tools ];
      networking.firewall = {
        allowedUDPPorts = [ 12346 ];
      };
      networking.wireguard.interfaces = {
        wg0 = {
          ips = [ "192.168.76.6" ];
          listenPort = 12346;
          #adress = "192.168.77.6";
          privateKeyFile = "/home/localhost/wireguard-keys/private";

          peers = [
            {
              publicKey = "cRk0cF+PHOvBaBmVe9jy9v+8ClVMGNLXmiHqEYFU/kg=";
              allowedIPs = ["192.168.76.0/22"];
              endpoint = "185.162.248.72:12346";
              persistentKeepalive = 25;
            }
          ];
        };
      };
    })
  ]);
}
