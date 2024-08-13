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
              test.enable = true;
              zsh.enable = true;
              waybar.enable = true;
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
              java11 = false;
              python = false;
            };

            server = {
              ssh = false;
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
              ohMy = false;
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
              ricing_fonts = true;
            };

            communication = {
              free = true;
              nonFree = true;
              bullshit = true;
              mailGui = true;
              mailTui = false;
              tdesktop = true;
            };

            android = {
               scrcpy = true;
               adb = true;
            };

            monitoring = {
              htop = true;
              iotop = true;
              btop = true;
              glances = true;
            };

            internet = {
              qute = true;
              yt-dlp = true;
            };

            util = {
              polkit = true;
              lock = true;
              xmonadUtil = false;
              swayUtil = true;
              neofetch = true;
              music = true;
              screenshot = true;
              theming = true;
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
              fingerprint = false;
              cloud = true;
              swaylockFix = true;
            };

            xorg = {
              enable = true;
              backlightFix = true;
              gpu = "intelAccelerated";
              xmonad = false;
              kde5 = false;
              xmobar = false;
              waybar = true;
              dunst = true;
              lightdm = false;
              sddm = false;
              gtkgreet = true;
              libinput = true;
              flatInput = false;
              wacom = true;
              stalone = false;
            };

            networking  = {
              bluetooth = true;
              networkManager = true;
            };

            hardware.Diana = true;

          };
        
    }) 
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "Diana";
        useDHCP = false;
        hostId = "5457b35a";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;
      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";
      hardware.enableRedistributableFirmware = true;

    })
  ];
}
