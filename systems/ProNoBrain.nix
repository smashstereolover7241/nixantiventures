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

            terminals = {
              alacritty = true;
              termite = true;
            };

            ssh = {
              enable = true;
            };

            wireguard = {
              enable = true;
            };

            theGrandUtilities = {
              enable = true;
            };

            filemanagers = {
              gui = true;
              tui = true;
            };

            zsh = {
              enabled = true;
              ohMy = true;
            };

            games = {
              steam = false;
              minecraft = false;
            };

            pulseaudio.enable = true;

            fonts = {
              firaCode = true;
            };

            communication = {
              free = true;
              nonFree = true;
              bullshit = false;
              mailGui = true; 
            };

            util = {
              xmonadUtil = false;
              neofetch = true;
              music = false;
              screenshot = true;
              theming = false;
              topFamily = true;
              driveUtil = true;
              emacs = false;
              media = true;
              encoding = false;
              pulseUtil = true;
              textUtil = true;
              office = true;
              password = false;
              compilerUtil = true;
              haskell = false;
              termUtil = true;
              painting = true;
              gpg = true;
            };

            xorg = {
              enable = true;
              gpu = "modesetting";
              xmonad = false;
              kde = true;
              xmobar = false;
              dunst = false;
              lightdm = true;
              libinput = true;
              flatInput = false;
            };

            networking  = {
              bluetooth = true;
              networkManager = true;
            };

            hardware.ProNoBrain = true;
            flakes.enable = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "ProNoBrain";
        useDHCP = false;
        hostId = "5457b356";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.version = 2;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;

      i18n.supportedLocales = ["all"];
      i18n.defaultLocale = "de_DE.UTF-8";

      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";
      hardware.enableRedistributableFirmware = true;
    })
  ];
}
