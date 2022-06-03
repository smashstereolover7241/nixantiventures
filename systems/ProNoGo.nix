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
              rust = true;
              python = true;
            };

            filemanagers = {
              gui = true;
              tui = true;
              smb = true;
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
              office = true;
              password = true;
              compilerUtil = true;
              haskell = true;
              termUtil = true;
              painting = true;
              qute = true;
            };

            xorg = {
              enable = true;
              gpu = "nvidia";
              xmonad = true;
	      pass = false;
              xmobar = true;
              dunst = true;
              kde = false;
              lightdm = true;
              libinput = false;
              flatInput = true;
            };

            networking  = {
              bluetooth = true;
              networkManager = true;
            };

            hardware.ProNoGo = true;
            flakes.enable = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "ProNoGo";
        useDHCP = false;
        hostId = "3532b394";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.version = 2;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;

  programs.adb.enable = true;

      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";

#virtualisation.libvirtd.enable = true;
#programs.dconf.enable = true;
#environment.systemPackages = with pkgs; [ virt-manager ];

    })
  ];
}
