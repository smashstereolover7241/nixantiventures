{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.internet;
in {
  options.teletypeOne.internet = {
    firefox = mkEnableOption "Installs firefox";
    librewolf = mkEnableOption "Installs better firefox (librewolf)";
    qute = mkEnableOption "Install qutebrowser";
    links2 = mkEnableOption "Install links2";
    yt-dlp = mkEnableOption "Install yt-dlp";
    openvpn = mkEnableOption "install openvpn";
    mullvad = mkEnableOption "install mullvad";
  };

  config = (mkMerge [
    (mkIf cfg.firefox {
      environment.systemPackages = with pkgs; [firefox];
    })

    (mkIf cfg.librewolf {
      environment.systemPackages = with pkgs; [librewolf];
    })

    (mkIf cfg.qute {
      environment.systemPackages = with pkgs; [qutebrowser];
    })

    (mkIf cfg.links2 {
      environment.systemPackages = with pkgs; [links2];
    })

    (mkIf cfg.yt-dlp {
      environment.systemPackages = with pkgs; [yt-dlp];
    })

    (mkIf cfg.openvpn {
      environment.systemPackages = with pkgs; [openvpn];
    })

    (mkIf cfg.mullvad {
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
    })

    #TODO: Move WireGuard clients here
  ]);
}
