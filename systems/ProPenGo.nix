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
            };

            lang = {
              rust = true;
              python = true;
            };
            ssh = {
              enable = false;
            };

            wireguard = {
              enable = false;
            };

            theGrandUtilities = {
              enable = false;
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
              steam = true;
              minecraft = false;
            };

            pulseaudio.enable = false;
            pipewire.enable = true;

            fonts = {
              firaCode = true;
            };

            communication = {
              free = true;
              nonFree = true;
              bullshit = true;
              mailGui = true; 
            };

            util = {
              cloud = true;
              xmonadUtil = true;
              neofetch = true;
              music = true;
              screenshot = true;
              theming = true;
              maths = true;
              topFamily = true;
              driveUtil = true;
              emacs = true;
              media = true;
              encoding = false;
              pulseUtil = true;
              textUtil = true;
              office = true;
              password = true;
              compilerUtil = true;
              haskell = true;
              termUtil = true;
              painting = true;
              gpg = false;
              fingerprint = true;
            };

            xorg = {
              enable = true;
              backlightFix = true;
              gpu = "modesetting";
              xmonad = true;
              kde = false;
              xmobar = true;
              dunst = true;
              lightdm = true;
              libinput = true;
              flatInput = false;
              wacom = true;
            };

            networking  = {
              bluetooth = true;
              networkManager = true;
            };

            hardware.ProPenGo = true;
            flakes.enable = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "ProPenGo";
        useDHCP = false;
        hostId = "5457b35a";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.version = 2;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages =  with pkgs; [python-validity ntfs3g];

      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";
      hardware.enableRedistributableFirmware = true;
    })
  ];
}
