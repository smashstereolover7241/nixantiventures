inputs: {
  system = "x86_64-linux";

  modules = [
    ../nixos-modules/default.nix
    inputs.home-manager.nixosModules.home-manager

    ({ pkgs, config, lib, ... }:
      let
        inherit (config.teletypeOne.pkgs) nixpkgs-unstable;
      in
        {
	  home-manager.users."localhost" = 
	  { ... } : {
	     imports = [ ../home-manager/modules/default.nix ];
             teletypeOne.hm = {
                zsh.enable = false;
		waybar.enable = false;
		hyprland.enable = false;
		hyprland.full = false;
	     };
             home.stateVersion = "20.09";
	  };
          teletypeOne = {

            pins = inputs;
            overlays = inputs.self.overlays;

            theGrandUtilities.enable = true;
            ssh.enable = true;

            terminals = {
              alacritty = true;
              termite = false;
              kitty = true;
            };

            lang = {
              python = false;
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
              minecraftLibFix = true;
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
              lock = false;
              cloud = false;
              xmonadUtil = false;
	      hyprlandUtil = false;
              neofetch = true;
              music = true;
              screenshot = true;
              theming = true;
              topFamily = true;
              driveUtil = true;
              emacs = true;
              media = true;
	      librewolf = true;
	      firefox = true;
              encoding = true;
              pulseUtil = true;
              textUtil = true;
              office = true;
              password = true;
              compilerUtil = true;
              haskell = false;
              termUtil = true;
              painting = true;
              qute = true;
              gpg = true;
              wine = true;
              wineland = true;
	      swaylockFix = false;
	      compression = true;
            };

            xorg = {
              enable = true;
	      stalone = false;
              firmware = true;
              gpu = "nvidia";
              xmonad = false;
              kde = true;
              pass = false;
              xmobar = false;
	      waybar = false;
              dunst = false;
              lightdm = true;
              libinput = true;
              flatInput = true;
	      gtkgreet = false;
	      hyprland = false;
            };

            networking  = {
              bluetooth = true;
              networkManager = true;
            };

            android = {
              adb = true;
              scrcpy = true;
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
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;

      services.logrotate.checkConfig = false;
      #workaround to make it build, yay

      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";

    })
  ];
}
