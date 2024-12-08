{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.media.internet.vpn.wireguardServer;
in
{
  options.modules.normal.media.internet.vpn.wireguardServer = {
    enable = mkEnableOption "Enable the wireguard Server";
    listenPort = mkOption {
      description = "what port to use.";
      type = types.int;
      default = 51938;
    };

    subNet = mkOption {
      description = "what subnet to use. currently kinda hardcoded";
      type = types.str;
      default = "51";
    };

    internalInterface = mkOption {
      description = "the internal interface";
      type = types.str;
      default = "wg0";
    };

    externalInterface = mkOption {
      description = "the external interface";
      type = types.str;
      default = "ens3";
    };

    peers = mkOption {
      description = "list of peers";
      #type = types.int;
      type = types.listOf (types.anything); # if messed up, type checker will complain anyways
      default = [];
    };

    keyFile = mkOption {
      description = "where is keyfile";
      type = types.str;
      default = "/secrets/current-system/wgpriv";
    };
  };

  config =
    (mkIf cfg.enable {
      # install wireguard
      environment.systemPackages = with pkgs; [ wireguard-tools ];
      # enable NAT
      networking.nat.enable = true;
      networking.nat.externalInterface = cfg.externalInterface;
      networking.nat.internalInterfaces = [ cfg.internalInterface ];
      networking.firewall = {
        allowedTCPPorts = [ 53 ];
        allowedUDPPorts = [ 53 cfg.listenPort ];
      };
      services.dnsmasq = {
          enable = true;
          settings =
          {
            interface = cfg.internalInterface;
          };
      };
      networking.wireguard.interfaces = {
        # "wg0" is the network interface name. You can name the interface arbitrarily.
        ${cfg.internalInterface} = {
          # Determines the IP address and subnet of the server's end of the tunnel interface.
          ips = [ "10.${cfg.subNet}.0.1/24" ];

          # The port that WireGuard listens to. Must be accessible by the client.
          listenPort = cfg.listenPort;

          # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
          # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
          postSetup = ''
            ${pkgs.iptables}/bin/iptables -A FORWARD -i ${cfg.internalInterface} -j ACCEPT
            ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.${cfg.subNet}.0.0/24 -o eth0 -j MASQUERADE
          '';

          # This undoes the above command
#          postShutdown = ''
#            ${pkgs.iptables}/bin/iptables -D FORWARD -i ${cfg.internalInterface} -j ACCEPT
#            ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.${cfg.subNet}.0.0/24 -o eth0 -j MASQUERADE
#          '';

          # Path to the private key file.
          #
          # Note: The private key can also be included inline via the privateKey option,
          # but this makes the private key world-readable; thus, using privateKeyFile is
          # recommended.
          privateKeyFile = cfg.keyFile;

          peers = cfg.peers;
        };
      };
    }
    );
}
