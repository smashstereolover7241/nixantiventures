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
              minecraft = true;
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
              mailTui = true;
            };

            util = {
              xmonadUtil = true;
              neofetch = true;
              music = true;
              screenshot = true;
              theming = true;
              topFamily = true;
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
            };

            xorg = {
              enable = true;
              gpu = "nvidia";
	      nvidia = {
		prime = true;
		intelBusId = "PCI:0:2:0";
		nvidiaBusId = "PCI:1:0:0";
		};
              xmonad = true;
              xmobar = true;
              dunst = true;
              kde = false;
              lightdm = true;
              libinput = true;
              flatInput = false;
            };

            networking  = {
              bluetooth = true;
              networkManager = true;
            };

            hardware.ProProGo = true;
            flakes.enable = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "ProProGo";
        useDHCP = false;
        hostId = "3532b394";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.version = 2;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;

  programs.adb.enable = true;

      time.timeZone = "Europe/Berlin";
       hardware.enableRedistributableFirmware = true; 
      system.stateVersion = "21.05";
    })
  ];
}
