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
            test.enable = false;
            zsh.enable = true;
            waybar.enable = false;
            hyprland.enable = false;
            hyprland.full = false;
	    hyprland.scaling = "1.5";
            hyprland.swayidle.enable = false;
            hyprland.hyprpaper.enable = false;
            hyprland.hyprpaper.paperName = "~/papers/a.jpg";
            hyprland.swaylock.enable = false;
        };
              home.stateVersion = "20.09";
        };
      teletypeOne = {

        pins = inputs;
        overlays = inputs.self.overlays;

        terminals = {
          alacritty = false;
          termite = true;
          kitty = true;
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
          minecraft = true;
        };

        pulseaudio.enable = false;
        pipewire.enable = true;

        fonts = {
          firaCode = true;
          ricing_fonts = true;
        };

        communication = {
          free = true;
          nonFree = true;
          bullshit = true;
          tdesktop = true;
          mailGui = true;
          mailTui = true;
        };

        util = {
	  polkit = true;
          xmonadUtil = true;
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
          haskell = true;
          termUtil = true;
          maths = true;
          painting = true;
          cloud = true;
          qute = true;
          swaylockFix = false;
          hyprlandUtil = false;

        };

        xorg = {
          backlightFix = true;
          enable = true;
          gpu = "nvidia";
          nvidia = {
            prime = true;
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
          };
          xmonad = false;
          xmobar = false;
          dunst = true;
          kde = true;
          lightdm = true;
          gtkgreet = false;
          libinput = false;
          flatInput = true;
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
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;

      programs.adb.enable = true;

      time.timeZone = "Europe/Berlin";
      hardware.enableRedistributableFirmware = true;
      system.stateVersion = "21.05";
    })
  ];
}
