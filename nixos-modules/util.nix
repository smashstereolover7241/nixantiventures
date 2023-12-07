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
    openvpn = mkEnableOption "install openvpn";
    maths = mkEnableOption "install math stuff";
    fingerprint = mkEnableOption "Install fprintd";
    cloud = mkEnableOption "Install nextcloud";
    qute = mkEnableOption "Install qutebrowser";
    lock = mkEnableOption "Install betterlockscreen";
    scrcpy = mkEnableOption "Install scrcpy";
    polkit = mkEnableOption "Install a policykit";
    wine = mkEnableOption "Install wine";
    wineland = mkEnableOption "Install wine with native wayland";
  };

  config = (mkMerge [
    (mkIf cfg.scrcpy{
      environment.systemPackages = with pkgs; [scrcpy];
    })

    (mkIf cfg.xmonadUtil {
      environment.systemPackages = with pkgs; [wmctrl rofi gmrun dunst arandr xorg.xkill acpilight playerctl alsa-utils];
    })

    (mkIf cfg.neofetch {
      environment.systemPackages = with pkgs; [lolcat neofetch];
    })

    (mkIf cfg.music {
      environment.systemPackages = with pkgs; [ncmpcpp mpd];
    })

    (mkIf cfg.screenshot {
      environment.systemPackages = with pkgs; [gnome.gnome-screenshot scrot];
    })

    (mkIf cfg.theming {
      environment.systemPackages = with pkgs; [lxappearance arc-theme papirus-icon-theme];
    })

    (mkIf cfg.topFamily {
      environment.systemPackages = with pkgs; [htop iotop glances btop];
    })

    (mkIf cfg.driveUtil {
      environment.systemPackages = with pkgs; [gparted ncdu meld hdparm libatasmart];
    })

    (mkIf cfg.emacs {
      environment.systemPackages = with pkgs; [emacs xorg.xwininfo xdotool xclip unzip sqlite libtool direnv nix-direnv];
    })

    (mkIf cfg.media {
      environment.systemPackages = with pkgs; [firefox links2 vlc feh peek];
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
      environment.systemPackages = with pkgs; [cmake gnumake git pkg-config zlib];
    })

    (mkIf cfg.haskell {
      environment.systemPackages = with pkgs; [cabal-install ghc haskellPackages.digest];
    })

    (mkIf cfg.termUtil {
      environment.systemPackages = with pkgs; [eza tmux];
    })

    (mkIf cfg.painting {
      environment.systemPackages = with pkgs; [kolourpaint krita gimp];
    })

    (mkIf cfg.painting {
      environment.systemPackages = with pkgs; [openvpn];
    })

    (mkIf cfg.cloud {
      environment.systemPackages = with pkgs; [nextcloud-client];
    })

    (mkIf cfg.maths {
      environment.systemPackages = with pkgs; [xournalpp ];
    })

    (mkIf cfg.fingerprint {
      services.fprintd.enable = true;
    })

    (mkIf cfg.qute {
      environment.systemPackages = with pkgs; [qutebrowser];
    })

    (mkIf cfg.polkit {
      environment.systemPackages = with pkgs; [ lxqt.lxqt-policykit ];
    })

    (mkIf cfg.wine {
      environment.systemPackages = with pkgs; [ wineWowPackages.staging ];
    })

    (mkIf cfg.wineland {
      environment.systemPackages = with pkgs; [ wineWowPackages.waylandFull ];
    })

    (mkIf cfg.lock {
      environment.systemPackages = with pkgs; [ betterlockscreen ];
      programs.xss-lock.enable = true;
      programs.xss-lock.lockerCommand = "${pkgs.betterlockscreen}/bin/betterlockscreen -l blur";
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
