{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.server;
in {
  options.teletypeOne.server = {
    ssh = mkEnableOption "Enable ssh";
    wireguard = mkEnableOption "Install wireguard client";
    wireguardAshley = mkEnableOption "Install wireguard client";
    wireguardServer = mkEnableOption "Install wireguard server";
    shadowsocks = mkEnableOption "Install shadowsocks server";
    utilPkgs = mkEnableOption "Option to get basics on servers";
  };

  config = (mkMerge [
    (mkIf cfg.ssh {
      services.sshd.enable = true;
      services.openssh.settings.PasswordAuthentication = false;
      services.openssh.ports = [ 1529 ];
    })
    (mkIf cfg.wireguard {
      #legacy wireguard setting
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
    (mkIf cfg.wireguardAshley {
      #TODO: make this proper options
      environment.systemPackages = with pkgs; [ wireguard-tools ];
      networking.firewall = {
        allowedUDPPorts = [ 21841 ];
      };
      networking.wireguard.interfaces = {
        wg0 = {
          ips = [ "10.51.0.3/24" ];
          listenPort = 21841;
          #adress = "192.168.77.6";
          privateKeyFile = "/home/localhost/wireguard-keys/current-system/private";

          peers = [
            {
              publicKey = "W2Ui8QW5nDkOM/GeoWyPdN/5dROT0Lm5GfCrSgxU7W8=";
              allowedIPs = ["10.51.0.0/24"];
              endpoint = "185.162.248.72:51938";
              persistentKeepalive = 25;
            }
          ];
        };
      };
    })
    (mkIf cfg.wireguardServer {
      # install wireguard
      environment.systemPackages = with pkgs; [ wireguard-tools ];
      # enable NAT
      networking.nat.enable = true;
      networking.nat.externalInterface = "ens3";
      networking.nat.internalInterfaces = [ "wg0" ];
      networking.firewall = {
        allowedTCPPorts = [ 53 ];
        allowedUDPPorts = [ 53 51938 ];
      };
      services.dnsmasq = {
          enable = true;
          extraConfig = ''
            interface=wg0
          '';
      };
      networking.wireguard.interfaces = {
        # "wg0" is the network interface name. You can name the interface arbitrarily.
        wg0 = {
          # Determines the IP address and subnet of the server's end of the tunnel interface.
          ips = [ "10.51.0.1/24" ];

          # The port that WireGuard listens to. Must be accessible by the client.
          listenPort = 51938;

          # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
          # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
          postSetup = ''
            ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
            ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.51.0.0/24 -o eth0 -j MASQUERADE
          '';

          # This undoes the above command
          postShutdown = ''
            ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
            ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.51.0.0/24 -o eth0 -j MASQUERADE
          '';

          # Path to the private key file.
          #
          # Note: The private key can also be included inline via the privateKey option,
          # but this makes the private key world-readable; thus, using privateKeyFile is
          # recommended.
          privateKeyFile = "/root/wireguard-keys/private";

          peers = [
            # List of allowed peers.
            { # Feel free to give a meaning full name
              # Public key of the peer (not a file path).
              publicKey = "FRhws1kkiUBQ91UGTMWzuPH5wUn9v16tfJFQnu7r4TM=";
              # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
              allowedIPs = [ "10.51.0.2/32" ];
            }
            { # ashley
              publicKey = "L+rvPGrgJc5yjhD7mF+uCqKc7hRTkmWCcPftNpgbZVU=";
              allowedIPs = [ "10.51.0.3/32" ];
            }
            { # p6
              publicKey = "ksSAc7+W1/tlju7/h89U6eq4vo9mojLhY7PjbKc8WHQ=";
              allowedIPs = [ "10.51.0.4/32" ];
            }
            { # luna
              publicKey = "nJUPEKSCUr/oJjdAe36UIeHGlEJ+3TpE7pxOWkS0Yjg=";
              allowedIPs = [ "10.51.0.5/32" ];
            }
            { # owo
              publicKey = "bccaq3hnXCMNGRILykO225ezENYb9x0qB4AQArD0mXA=";
              allowedIPs = [ "10.51.0.6/32" ];
            }
          ];
        };
      };
    })
    (mkIf cfg.shadowsocks {
      services.shadowsocks = {
        enable = true;
        port = 8390; # default
        passwordFile = "/root/keys/shadowsocks"; # put something random there and send it to me
        mode = "tcp_and_udp"; # don't forget to open the firewall
        localAddress = ["0.0.0.0"]; # bind addr
      }; # rest should be fine by default
      networking.firewall = {
        allowedUDPPorts = [ 8390 ];
        allowedTCPPorts = [ 8390 ];
      };
    })
    (mkIf cfg.utilPkgs {
      environment.systemPackages = with pkgs; [ vim neovim git neofetch ]; # neofetch cause obv...
    })
  ]);

}
