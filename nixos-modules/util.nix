{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.util;
in {
  options.teletypeOne.util = {
    xmonadUtil = mkEnableOption "Install utility programs for xmonad";
    hyprlandUtil = mkEnableOption "Install utility programs for hyprland";
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
    polkit = mkEnableOption "Install a policykit";
    wine = mkEnableOption "Install wine";
    wineland = mkEnableOption "Install wine with native wayland";
    notes = mkEnableOption "Install notetaking apps (logseq)";
    swaylockFix = mkEnableOption "Add fix for swaylock";
    yt-dlp = mkEnableOption "Install yt-dlp";
  };

  config = (mkMerge [
    (mkIf cfg.xmonadUtil {
      environment.systemPackages = with pkgs; [wmctrl rofi gmrun dunst arandr xorg.xkill acpilight playerctl alsa-utils];
    })

    (mkIf cfg.hyprlandUtil {
      environment.systemPackages = with pkgs; [light hyprshot hyprland-protocols xdg-desktop-portal-hyprland
 hyprshade wmctrl wofi gmrun dunst arandr acpilight playerctl alsa-utils];
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
	  musicDirectory = "/home/localhost/music";
	  user = "localhost";
#environment.XDG_RUNTIME_DIR = "/run/user/1000";
	  extraConfig = ''
		  audio_output {
		    type "pipewire"
		    name "PipeWire alla"
		  }
	  '';

	  # Optional:
#	  network.listenAddress = "any"; # if you want to allow non-localhost connections
	  startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
};

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

    (mkIf cfg.openvpn {
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
      environment.systemPackages = with pkgs; [ wineWowPackages.stable ];
    })

    (mkIf cfg.wineland {
      environment.systemPackages = with pkgs; [ wineWowPackages.waylandFull ];
    })

    (mkIf cfg.notes {
      environment.systemPackages = with pkgs; [ logseq ];
    })

    (mkIf cfg.yt-dlp {
      environment.systemPackages = with pkgs; [ yt-dlp ];
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
        pinentryFlavor = "gtk2";
        enableSSHSupport = true;
      };
    })
  ]);
}
