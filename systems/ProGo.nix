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

            pulseaudio.enable = true;

            fonts = {
              firaCode = true;
            };

            communication = {
              free = true;
              nonFree = true;
              bullshit = true;
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
              painting = false;
            };

            xorg = {
              enable = true;
              gpu = "modesetting";
              xmonad = true;
              xmobar = true;
              lightdm = true;
              libinput = true;
            };

            networking  = {
              bluetooth = true;
              networkManager = true;
            };

            hardware.ProGo = true;
            flakes.enable = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "ProGo";
        useDHCP = false;
        hostId = "3457b394";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.version = 2;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;

      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";
    })
  ];
}
