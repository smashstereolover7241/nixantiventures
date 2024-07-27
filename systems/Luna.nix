inputs: {
  system = "x86_64-linux";

  modules = [
    ../nixos-modules/default.nix
    ({ pkgs, config, lib, ... }:
      let
        inherit (config.teletypeOne.pkgs) nixpkgs-unstable;
      in
        {
          teletypeOne = {

            pins = inputs;
            overlays = inputs.self.overlays;

            terminals = {
              alacritty = true;
              termite = false;
              kitty = true;
            };

            filemanagers = {
              gui = true;
              tui = true;
              smb = true;
            };

            lang = {
              python = false;
              java17 = true;
            };

            server = {
              ssh = false;
              wireguard = false;
            };

            theGrandUtilities = {
              enable = false;
            };

            zsh = {
              enabled = true;
              ohMy = true;
            };

            games = {
              steam = false;
              minecraft = true;
              minecraftLibFix = true;
            };

            pulseaudio.enable = false;
            pipewire.enable = true;
            pipewire.easyeffects = true;

            fonts = {
              firaCode = true;
              all_the_icons = true;
              ricing_fonts = true;
            };

            communication = {
              free = false;
              nonFree = false;
              bullshit = false;
              mailTui = false;
              mailGui = false;
              tdesktop = false;
            };

            util = {
              lock = true;
              yt-dlp = true;
              cloud = false;
              xmonadUtil = true;
              swayUtil = false;
              neofetch = true;
              music = false;
              screenshot = true;
              theming = true;
              topFamily = true;
              driveUtil = true;
              emacs = true;
              media = true;
              encoding = true;
              pulseUtil = true;
              textUtil = true;
              office = false;
              password = true;
              compilerUtil = true;
              haskell = true;
              termUtil = true;
              painting = false;
              gpg = true;
              qute = true;
              wine = false;
              wineland = false;
              openvpn = false;
              maths = false;
              fingerprint = false;
              notes = false;
              polkit = true;
              swaylockFix = false;
            };

            xorg = {
              enable = true;
              gpu = "modesetting";
              backlightFix = false;
              nvidia = {
                prime = true;
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
              };
              xmonad = true;
              xmobar = true;
              waybar = false;
              stalone = true;
              kde6 = false;
              dunst = true;
              pass = true;
              lightdm = false;
              sddm = true;
              gtkgreet = false;
              libinput = false;
              flatInput = true;
              wacom = false;
              firmware = true;
            };

            networking  = {
              bluetooth = true;
              networkManager = true;
            };

            android = {
              adb = true;
              scrcpy = true;
            };

            hardware.Luna = true;
            flakes.enable = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "Luna";
        useDHCP = false;
        hostId = "3457b394";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;

      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";
    })
  ];
}
