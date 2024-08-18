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
      home-manager.extraSpecialArgs = { inherit inputs;}; # !!! LOOK AT THIS! EMACS!! (emacs does not work without this)
      home-manager.users."localhost" =
      { ... } : {
        imports = [ ../home-manager/modules/default.nix ];
        teletypeOne.hm = {
            test.enable = false;
            zsh.enable = true;
            editors.emacs.enable = true;
            waybar.enable = false;
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
          steam = true;
          lutris = true;
          minecraft = true;
          heroic = true;
          bottles = true;
          wheel = true;
          wine = true;
          wineland = true;
        };

        pulseaudio.enable = false;
        pipewire.enable = true;
        pipewire.easyeffects = true;

        fonts = {
          firaCode = true;
          ricing_fonts = true;
          all_the_icons = true;
        };

        lang = {
          python = true;
        };

        communication = {
          free = true;
          nonFree = true;
          bullshit = true;
          tdesktop = true;
          mailGui = true;
          mailTui = true;
        };

        monitoring = {
          htop = true;
          iotop = true;
          btop = true;
          glances = true;
          missioncenter = true;
        };

        internet = {
          firefox = true;
          librewolf = true;
          qute = false;
          links2 = true;
        };

        util = {
          polkit = true;
          xmonadUtil = true;
          neofetch = true;
          music = true;
          screenshot = true;
          theming = true;
          driveUtil = true;
          emacs = false;
          media = true;
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
          cloud = false;
          swaylockFix = true;
          swayUtil = true;
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
          kde5 = false;
          kde6 = true;
          lightdm = true;
          gtkgreet = false;
          libinput = false;
          flatInput = false;
        };

        networking  = {
          bluetooth = true;
          networkManager = true;
        };

        hardware.Ashley = true;
        flakes.enable = true;

      };
    }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "Ashley";
        useDHCP = false;
        hostId = "3532b394";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;

      programs.adb.enable = true;
      services.logrotate.checkConfig = false;

      time.timeZone = "Europe/Berlin";
      hardware.enableRedistributableFirmware = true;
      system.stateVersion = "21.05";
    })
  ];
}
