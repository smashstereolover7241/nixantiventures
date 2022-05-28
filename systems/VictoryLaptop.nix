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
              kitty = true;
              termite = false;
            };

            lang = {
              rust = false;
              python = false;
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
            pipewire.easyeffects = true;

            fonts = {
              firaCode = true;
            };

            communication = {
              free = true;
              nonFree = true;
              bullshit = true;
              mailGui = true;
              mailTui = true;
              tdesktop = true;
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
              office = false;
              password = true;
              compilerUtil = true;
              haskell = true;
              termUtil = true;
              painting = true;
              cloud = true;
              qute = true;
              polkit = true;
            };

            xorg = {
              enable = true;
              gpu = "null";
              xmonad = true;
              xmobar = true;
              dunst = true;
              kde = false;
              lightdm = false;
              sddm = true;
              libinput = false;
              flatInput = true;
              firmware = true;
            };

            networking  = {
              bluetooth = true;
              networkManager = true;
            };

            hardware.VictoryLaptop = true;
            flakes.enable = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "VictoryLaptop";
        useDHCP = false;
        hostId = "3532b395";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.version = 2;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;

      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";

#virtualisation.libvirtd.enable = true;
#programs.dconf.enable = true;
#environment.systemPackages = with pkgs; [ virt-manager ];

    })
  ];
}
