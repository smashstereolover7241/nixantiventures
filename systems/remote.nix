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
              alacritty = false;
              termite = false;
              kitty = false;
            };

            filemanagers = {
              gui = false;
              tui = false;
              smb = false;
            };

            lang = {
              python = false;
              java11 = false;
            };

            emulation = {
              enabled = false;
              virtmanager = false;
            };

            server = {
              ssh = true;
              wireguard = false;
              wireguardServer = true;
              utilPkgs = true;
            };

            theGrandUtilities = {
              enable = false;
            };

            zsh = {
              enabled = false;
              ohMy = false;
            };

            games = {
              steam = false;
              minecraft = false;
              minecraftLibFix = false;
              lutris = false;
              heroic = false;
              wheel = false;
              bottles = false;
            };

            pulseaudio.enable = false;
            pipewire.enable = false;
            pipewire.easyeffects = false;

            fonts = {
              firaCode = false;
              all_the_icons = false;
              ricing_fonts = false;
            };

            communication = {
              free = false;
              nonFree = false;
              bullshit = false;
              mailTui = false;
              mailGui = false;
              tdesktop = false;
            };

            util = {
              lock = false;
              yt-dlp = false;
              cloud = false;
              xmonadUtil = false;
              swayUtil = false;
              neofetch = false;
              music = false;
              screenshot = false;
              theming = false;
              topFamily = false;
              driveUtil = false;
              emacs = false;
              media = false;
              firefox = false;
              librewolf = false;
              encoding = false;
              pulseUtil = false;
              textUtil = false;
              office = false;
              password = false;
              compilerUtil = false;
              haskell = false;
              termUtil = false;
              painting = false;
              gpg = false;
              qute = false;
              wine = false;
              wineland = false;
              openvpn = false;
              maths = false;
              fingerprint = false;
              notes = false;
              polkit = false;
              swaylockFix = false;
              compression = false;
              missioncenter = false;
            };

            xorg = {
              enable = false;
              gpu = "none";
              backlightFix = false;
              nvidia = {
                prime = false;
              };
              xmonad = false;
              xmobar = false;
              waybar = false;
              stalone = false;
              kde5 = false;
              kde6 = false;
              dunst = false;
              pass = false;
              lightdm = false;
              sddm = false;
              gtkgreet = false;
              libinput = false;
              flatInput = false;
              wacom = false;
              firmware = false;
            };

            networking  = {
              bluetooth = false;
              networkManager = true;
            };

            android = {
              adb = false;
              scrcpy = false;
            };

            hardware.remote = true;
            flakes.enable = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "remote";
        useDHCP = false;
        hostId = "3457b395";
      };

      boot.loader.grub.enable = true;
      boot.loader.grub.device = "/dev/vda";
      boot.loader.grub.enableCryptodisk = true;
      nixpkgs.config.allowUnfree = true;

      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";

      boot.initrd = {
        availableKernelModules = [ "virtio_net" ];
        network = {
          enable = true;
          udhcpc.enable = true;
          flushBeforeStage2 = true;
          ssh = {
            enable = true;
            port = 9875;
            authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL4l4g4cP18QYi29pes7qXaWspme9u5fIM1m9RmxWCIP" ];
            hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
          };
          postCommands = ''
            # Automatically ask for the password on SSH login
            echo 'cryptsetup-askpass || echo "Unlock was successful; exiting SSH session" && exit 1' >> /root/.profile
          '';
        };
      };
    })
  ];
}
