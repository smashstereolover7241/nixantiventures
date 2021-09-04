{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.util;
in {
  options.teletypeOne.util = {
    xmonadUtil = mkEnableOption "Install utility programs for xmonad";
    neofetch = mkEnableOption "Install requirements for neofetch";
    music = mkEnableOption "Install (terminal) music applications";
    screenshot = mkEnableOption "Install all the usual screenshot tools";
    theming = mkEnableOption "Install tools for theming.";
    topFamily = mkEnableOption "Install all the top tools!";
    driveUtil = mkEnableOption "Install drive utilities";
    emacs = mkEnableOption "Install Emacs and whatever needed for the thing";
    media = mkEnableOption "Have the usual media consumption stuffs installed";
    encoding = mkEnableOption "Install tools to work with video / audio";
    pulseUtil = mkEnableOption "Install utilites to work with pulseawfulio";
    textUtil = mkEnableOption "Install text editors (not emacs)";
    office = mkEnableOption "Install office programs";
    password = mkEnableOption "Install password managers";
    compilerUtil = mkEnableOption "Install compiler stuff";
    haskell = mkEnableOption "You want haskell? You get haskell.";
    termUtil = mkEnableOption "Utilites for the terminal";
    painting = mkEnableOption "Some painting applications";
    gpg = mkEnableOption "Stuff for gpg";
  };

  config = (mkMerge [
    (mkIf cfg.xmonadUtil {
      environment.systemPackages = with pkgs; [wmctrl rofi gmrun dunst arandr xorg.xkill acpilight];
    })

    (mkIf cfg.neofetch {
      environment.systemPackages = with pkgs; [lolcat neofetch];
    })

    (mkIf cfg.music {
      environment.systemPackages = with pkgs; [ncmpcpp mpd];
    })

    (mkIf cfg.screenshot {
      environment.systemPackages = with pkgs; [gnome3.gnome-screenshot scrot];
    })

    (mkIf cfg.theming {
      environment.systemPackages = with pkgs; [lxappearance arc-theme papirus-icon-theme];
    })

    (mkIf cfg.topFamily {
      environment.systemPackages = with pkgs; [htop iotop glances bpytop];
    })

    (mkIf cfg.driveUtil {
      environment.systemPackages = with pkgs; [ncdu meld hdparm libatasmart];
    })

    (mkIf cfg.emacs {
      environment.systemPackages = with pkgs; [emacs sqlite libtool direnv nix-direnv];
    })

    (mkIf cfg.media {
      environment.systemPackages = with pkgs; [firefox links vlc feh peek];
    })

    (mkIf cfg.encoding {
      environment.systemPackages = with pkgs; [ffmpeg-full];
    })

    (mkIf cfg.pulseUtil {
      environment.systemPackages = with pkgs; [pavucontrol];
    })

    (mkIf cfg.textUtil {
      environment.systemPackages = with pkgs; [vim neovim geany];
    })

    (mkIf cfg.office {
      environment.systemPackages = with pkgs; [libreoffice-fresh];
    })

    (mkIf cfg.password {
      environment.systemPackages = with pkgs; [keepassxc];
    })

    (mkIf cfg.compilerUtil {
      environment.systemPackages = with pkgs; [cmake gnumake git pkgconfig zlib];
    })

    (mkIf cfg.haskell {
      environment.systemPackages = with pkgs; [cabal-install ghc haskellPackages.digest];
    })

    (mkIf cfg.termUtil {
      environment.systemPackages = with pkgs; [exa tmux];
    })

    (mkIf cfg.painting {
      environment.systemPackages = with pkgs; [kolourpaint gimp];
    })
    (mkIf cfg.gpg {
      environment.systemPackages = with pkgs; [gnupg pinentry];
      programs.gnupg.agent = {
        enable = true;
        pinentryFlavor = "curses";
      };
    })
  ]);
}
