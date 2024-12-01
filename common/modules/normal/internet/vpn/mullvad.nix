{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.internet.vpn.mullvad;
in
{
  options.modules.normal.internet.vpn.mullvad = {
    enable = mkEnableOption "Enable mullvad";
  };
  config =
    (mkIf cfg.enable {
      services.mullvad-vpn.enable = true;
      services.mullvad-vpn.package = pkgs.mullvad-vpn;
      networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

      services.resolved = {
        enable = true;
        dnssec = "true";
        domains = [ "~." ];
        fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
        dnsovertls = "true";
      };
    }
  );
}
