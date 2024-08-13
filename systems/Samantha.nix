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

            lang = {
              java11 = false;
              python = false;
            };

            server = {
              ssh = false;
              wireguard = false;
            };

            theGrandUtilities = {
              enable = false;
            };

            filemanagers = {
              gui = true;
              tui = false;
            };

            zsh = {
              enabled = true;
              ohMy = true;
            };

            games = {
              steam = false;
              minecraft = false;
            };

            pulseaudio.enable = false;
            pipewire.enable = true;
            pipewire.easyeffects = true;

            fonts = {
              firaCode = true;
              all_the_icons = true;
            };

            android = {
              adb = true;
              scrcpy = true;
            };

            communication = {
              free = true;
              nonFree = true;
              bullshit = true;
              mailGui = true;
              mailTui = false;
              tdesktop = true;
            };

            monitoring = {
              htop = true;
              iotop = true;
              btop = true;
              glances = true;
            };

            internet = {
              qute = true;
              links2 = true;
            };

            util = {
              lock = true;
              xmonadUtil = true;
              neofetch = true;
              music = true;
              screenshot = true;
              theming = true;
              driveUtil = true;
              emacs = true;
              media = true;
              encoding = false;
              pulseUtil = true;
              textUtil = true;
              office = false;
              password = true;
              compilerUtil = true;
              haskell = true;
              termUtil = true;
              painting = true;
              gpg = true;
              openvpn = true;
              maths = false;
              fingerprint = false;
              cloud = true;
              notes = true;
            };

            xorg = {
              enable = true;
              backlightFix = false;
              gpu = "intelAccelerated";
              xmonad = true;
              kde5 = false;
              kde6 = false;
              xmobar = true;
              dunst = true;
              lightdm = false;
              sddm = true;
              libinput = true;
              flatInput = false;
              wacom = true;
              wacomFix = true;
              stalone = true;
            };

            networking  = {
              bluetooth = true;
              networkManager = true;
            };

            hardware.Samantha = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "Samantha";
        useDHCP = false;
        hostId = "5457b35a";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;
      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";
      hardware.enableRedistributableFirmware = true;

    })
  ];
}
