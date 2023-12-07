{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.communication;
  discord-latest = pkgs.discord.overrideAttrs (old: {
    version = "0.0.24";
    src = pkgs.fetchurl {
      url = "https://dl.discordapp.net/apps/linux/0.0.24/discord-0.0.24.tar.gz";
      sha256 = "sha256-SG+34ft0mTqtg9rFiI60N6JIONyqF8c8SlnRcn5a4Xc=";
    };
  });
in {
  options.teletypeOne.communication = {
    free = mkEnableOption "Install free communication tools.";
    tdesktop = mkEnableOption "Install Telegram Desktop.";
    nonFree = mkEnableOption "Install nonfree communication tools.";
    bullshit = mkEnableOption "Install dumb communication tools.";
    mailGui = mkEnableOption "Install and add gui mail tools.";
    mailTui = mkEnableOption "Install and add tui mail tools";
  };

  config = (mkMerge [
    (mkIf (cfg.free) {
      environment.systemPackages = with pkgs; [signal-desktop element-desktop revolt-desktop];
    })

    (mkIf (cfg.nonFree) {
      environment.systemPackages = with pkgs; [discord-latest];
    })
    (mkIf (cfg.tdesktop) {
      environment.systemPackages = with pkgs; [tdesktop];
    })

    (mkIf (cfg.bullshit) {
      environment.systemPackages = with pkgs; [teams-for-linux];
    })

    (mkIf cfg.mailGui {
      environment.systemPackages = with pkgs; [thunderbird];
    })

    (mkIf cfg.mailTui {
      environment.systemPackages = with pkgs; [neomutt curl isync msmtp pass lynx notmuch abook urlview];
      teletypeOne.util.gpg = true; # gpg is required
    })
  ]);
}
