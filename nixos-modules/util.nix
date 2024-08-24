{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.util;
in {
  options.teletypeOne.util = {
    xmonadUtil = mkEnableOption "Install utility programs for xmonad";
    haskell = mkEnableOption "You want haskell? You get haskell.";
    swayUtil = mkEnableOption "Install utility programs for wayland tiling wms";
    neofetch = mkEnableOption "Install requirements for neofetch";
    screenshot = mkEnableOption "Install all the usual screenshot tools";
    theming = mkEnableOption "Install tools for theming.";
    driveUtil = mkEnableOption "Install drive utilities";
    emacs = mkEnableOption "Install Emacs and whatever needed for the thing";
    pulseUtil = mkEnableOption "Install utilites to work with pulseawfulio";
    textUtil = mkEnableOption "Install text editors (not emacs)";
    office = mkEnableOption "Install office programs";
    password = mkEnableOption "Install password managers";
    compilerUtil = mkEnableOption "Install compiler stuff";
    termUtil = mkEnableOption "Utilites for the terminal";
    painting = mkEnableOption "Some painting applications";
    gpg = mkEnableOption "Stuff for gpg";
    lock = mkEnableOption "Install betterlockscreen";
    maths = mkEnableOption "install math stuff";
    fingerprint = mkEnableOption "Install fprintd";
    cloud = mkEnableOption "Install nextcloud";
    polkit = mkEnableOption "Install a policykit";
    notes = mkEnableOption "Install notetaking apps (logseq)";
    swaylockFix = mkEnableOption "Add fix for swaylock";
    compression = mkEnableOption "Install compression utils";
    media = mkEnableOption "Have the usual media consumption stuffs installed";
    music = mkEnableOption "Install (terminal) music applications";
    encoding = mkEnableOption "Install tools to work with video / audio";
  };

  config = (mkMerge [
    (mkIf cfg.xmonadUtil {
      environment.systemPackages = with pkgs; [wmctrl rofi gmrun dunst arandr xorg.xkill acpilight playerctl alsa-utils];
    })

    (mkIf cfg.swayUtil {
      environment.systemPackages = with pkgs; [light  
        wmctrl wofi gmrun dunst arandr acpilight playerctl alsa-utils nwg-drawer wdisplays];
    })

    (mkIf cfg.swaylockFix {
      security.pam.services.swaylock = {
        text = ''
          auth include login
        '';
      };
    })

    (mkIf cfg.neofetch {
      environment.systemPackages = with pkgs; [lolcat neofetch];
    })

    (mkIf cfg.music {
      environment.systemPackages = with pkgs; [ncmpcpp mpd mpc-cli];
      services.mpd = {
        enable = true;
        musicDirectory = "/home/localhost/Music";
        user = "localhost";
        extraConfig = ''
          audio_output {
            type "pipewire"
            name "PipeWire alla"
          }
        '';
      };
        systemd.services.mpd.environment.XDG_RUNTIME_DIR = "/run/user/1000";
    })

    (mkIf cfg.screenshot {
      environment.systemPackages = with pkgs; [gnome-screenshot scrot];
    })

    (mkIf cfg.theming {
      environment.systemPackages = with pkgs; [lxappearance arc-theme papirus-icon-theme];
    })

    (mkIf cfg.driveUtil {
      environment.systemPackages = with pkgs; [gparted ncdu meld hdparm libatasmart];
    })

    (mkIf cfg.emacs {
      environment.systemPackages = with pkgs; [emacs xorg.xwininfo xdotool xclip unzip sqlite libtool direnv nix-direnv];
    })

    (mkIf cfg.media {
      environment.systemPackages = with pkgs; [vlc feh peek];
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
      environment.systemPackages = with pkgs; [cmake ninja gcc gnumake git pkg-config zlib];
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

    (mkIf cfg.cloud {
      environment.systemPackages = with pkgs; [nextcloud-client];
    })

    (mkIf cfg.maths {
      environment.systemPackages = with pkgs; [xournalpp ];
    })

    (mkIf cfg.fingerprint {
      services.fprintd.enable = true;
    })

    (mkIf cfg.polkit {
      environment.systemPackages = with pkgs; [ lxqt.lxqt-policykit ];
    })

    (mkIf cfg.notes {
      ##### Depends on too old electron, should currently not be used #####
      #environment.systemPackages = with pkgs; [ logseq ];
    })

    (mkIf cfg.compression {
      environment.systemPackages = with pkgs; [ pigz pv ];
    })

    (mkIf cfg.lock {
      environment.systemPackages = with pkgs; [ betterlockscreen ];
      programs.xss-lock.enable = true;
      programs.xss-lock.lockerCommand = "${pkgs.betterlockscreen}/bin/betterlockscreen -l blur";
    })

    (mkIf cfg.gpg {
      environment.systemPackages = with pkgs; [gnupg pinentry pinentry-gtk2 pinentry-curses];
      programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-gtk2;
        enableSSHSupport = true;
      };
    })
  ]);
}
