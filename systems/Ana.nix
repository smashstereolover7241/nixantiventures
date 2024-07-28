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
	  zsh.enable = true;
	  editors.emacs.enable = true;
	};
	home.stateVersion = "20.09";

      };
      teletypeOne = {

        pins = inputs;
        overlays = inputs.self.overlays;

        terminals = {
          alacritty = true;
          termite = false;
          kitty = true;
        };

        lang = {
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
          tui = true;
	  smb = true;
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
	  ricing_fonts = true;
          firaCode = true;
	  all_the_icons = true;
        };

        communication = {
          free = true;
          nonFree = true;
          bullshit = true;
          mailGui = true;
          mailTui = false;
          tdesktop = true;
        };

        util = {
          lock = true;
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
          gpg = true;
          openvpn = true;
          maths = true;
          fingerprint = true;
          cloud = true;
          qute = true;
	  librewolf = true;
        };

        xorg = {
          enable = true;
          backlightFix = true;
          gpu = "intelAccelerated";
          xmonad = true;
          kde5 = false;
          xmobar = true;
          dunst = true;
          lightdm = false;
          sddm = true;
          libinput = true;
          flatInput = false;
          wacom = false;
          stalone = false;
        };

        networking  = {
          bluetooth = true;
          networkManager = true;
        };

        hardware.Ana = true;
        flakes.enable = true;

      };
    }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "Ana";
        useDHCP = false;
        hostId = "5457b35a";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.device = "nodev";
      boot.loader.grub.enableCryptodisk = true;

      nixpkgs.config.allowUnfree = true;

      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";
      hardware.enableRedistributableFirmware = true;
    })
  ];
}
