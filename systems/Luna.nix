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

            filemanagers = {
              gui = true;
              tui = true;
              smb = true;
            };

            lang = {
              python = false;
              java17 = true;
            };

            server = {
              ssh = false;
              wireguard = false;
            };

            theGrandUtilities = {
              enable = false;
            };

            zsh = {
              enabled = true;
              ohMy = true;
            };

            games = {
              steam = false;
              minecraft = true;
              minecraftLibFix = true;
              wine = false;
              wineland = false;
            };

            pulseaudio.enable = false;
            pipewire.enable = true;
            pipewire.easyeffects = true;

            fonts = {
              firaCode = true;
              all_the_icons = true;
              ricing_fonts = true;
            };

            communication = {
              free = false;
              nonFree = false;
              bullshit = false;
              mailTui = false;
              mailGui = false;
              tdesktop = false;
            };

            monitoring = {
              htop = true;
              iotop = true;
              btop = true;
              glances = true;
            };

            internet = {
              librewolf = true;
              qute = true;
              yt-dlp = true;
              links2 = true;
            };

            util = {
              lock = true;
              cloud = false;
              xmonadUtil = true;
              swayUtil = false;
              neofetch = true;
              music = false;
              screenshot = true;
              theming = true;
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
              painting = false;
              gpg = true;
              openvpn = false;
              maths = false;
              fingerprint = false;
              notes = false;
              polkit = true;
              swaylockFix = false;
            };

            xorg = {
              enable = true;
              gpu = "nvidia";
              backlightFix = true;
              nvidia = {
                prime = true;
                version = "legacy_470";
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
              };
              xmonad = true;
              xmobar = true;
              waybar = false;
              stalone = true;
              kde6 = false;
              dunst = true;
              pass = true;
              lightdm = false;
              sddm = true;
              gtkgreet = false;
              libinput = false;
              flatInput = true;
              wacom = false;
              firmware = true;
            };

            networking  = {
              bluetooth = true;
              networkManager = true;
            };

            android = {
              adb = true;
              scrcpy = true;
            };

            hardware.Luna = true;
            flakes.enable = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "Luna";
        useDHCP = false;
        hostId = "3457b394";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.nvidia.acceptLicense = true;

      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";
    })
  ];
}
