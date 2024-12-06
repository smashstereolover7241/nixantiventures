{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.media.internet.vpn.wireguardClient;
in
{
  options.modules.normal.media.internet.vpn.wireguardClient = {
    enable = mkEnableOption "Enable the wireguard Client";
    ip = mkOption {
      description = "intellectual pro... no wait";
      type = types.str;
      default = "10.51.0.99/24";
    };

    internalInterface = mkOption {
      description = "the internal interface";
      type = types.str;
      default = "wg0";
    };
  };

  config =
    (mkIf cfg.enable {
      environment.systemPackages = with pkgs; [ wireguard-tools ];
      networking.wireguard.interfaces = {
        ${cfg.internalInterface}= {
          ips = [ cfg.ip ];
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
    }
  );
}
