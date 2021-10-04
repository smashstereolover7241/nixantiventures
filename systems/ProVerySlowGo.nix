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

            pulseaudio.enable = false;
            pipewire.enable = true;

            fonts = {
              firaCode = true;
            };

            communication = {
              free = true;
              nonFree = true;
              bullshit = false;
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
              encoding = false;
              pulseUtil = true;
              textUtil = true;
              office = false;
              password = true;
              compilerUtil = true;
              haskell = true;
              termUtil = true;
              painting = true;
              openvpn = true;
              maths = false;
            };

            xorg = {
              enable = true;
              gpu = "null";
              xmonad = true;
              xmobar = true;
              dunst = true;
              lightdm = false;
              sddm = true;
              libinput = true;
              flatInput = false;
            };

            networking  = {
              bluetooth = false;
              networkManager = true;
            };

            hardware.ProVerySlowGo = true;
            flakes.enable = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "ProVerySlowGo";
        useDHCP = false;
        hostId = "3532b394";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.version = 2;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;

      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";
      hardware.enableRedistributableFirmware = true;
#      services.xserver.displayManager.sddm.enable = true;
    })
  ];
}
