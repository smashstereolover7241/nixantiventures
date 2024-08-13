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
              termite = true;
              kitty = true;
            };

            filemanagers = {
              gui = true;
              tui = true;
              smb = true;
            };

            lang = {
              python = true;
              java11 = true;
            };

            emulation = {
              enabled = true;
              virtmanager = true;
            };

            server = {
              ssh = true;
              wireguard = false; #otherwise it complains about dual private key
              wireguardServer = true;
              utilPkgs = true;
            };

            theGrandUtilities = {
              enable = true;
            };

            zsh = {
              enabled = true;
              ohMy = true;
            };

            games = {
              steam = true;
              minecraft = true;
              minecraftLibFix = true;
              lutris = true;
              heroic = true;
              wheel = true;
              bottles = true;
              wine = true;
              wineland = true;
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
              free = true;
              nonFree = true;
              bullshit = true;
              mailTui = true;
              mailGui = true;
              tdesktop = true;
            };

            monitoring = {
              htop = true;
              iotop = true;
              btop = true;
              glances = true;
              nvtop = true;
              missioncenter = true;
            };

            internet = {
              firefox = true;
              librewolf = true;
              qute = true;
              yt-dlp = true;
            };

            util = {
              lock = true;
              cloud = true;
              xmonadUtil = true;
              swayUtil = true;
              neofetch = true;
              music = true;
              screenshot = true;
              theming = true;
              driveUtil = true;
              emacs = true;
              media = true;
              encoding = true;
              pulseUtil = true;
              textUtil = true;
              office = true;
              password = true;
              compilerUtil = true;
              haskell = true;
              termUtil = true;
              painting = true;
              gpg = true;
              openvpn = true;
              maths = true;
              fingerprint = true;
              notes = true;
              polkit = true;
              swaylockFix = true;
              compression = true;
            };

            xorg = {
              enable = true;
              gpu = "modesetting";
              backlightFix = true;
              nvidia = {
                prime = true;
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
              };
              xmonad = true;
              xmobar = true;
              waybar = true;
              stalone = true;
              kde5 = false;
              kde6 = true;
              dunst = true;
              pass = true;
              lightdm = true;
              sddm = false;
              gtkgreet = true;
              libinput = true;
              flatInput = true;
              wacom = true;
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

            hardware.sample = true;
            flakes.enable = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "sample";
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
