{ config, lib, pkgs, ... }@inputs:
let
    rootPath = (lib.filesystem.locateDominatingFile "flake.nix" ./.).path; # this is severly stupid, couldn't find a better way tho;
in
{
  imports = [ (rootPath + "/common/depmgr.nix") ];
  modules = {
    #enable = true;
    home-manager = {
      defaults = true;
      users.enable = true;
#      users.name = "localhost"; #Use default
      cli = {
        shell = {
          zsh.enable = true;
        };
#        zsh.username = "localhost"; #Use default
      };
    };
    normal = {
      cli = {
        shell = {
          zsh = {
            enable = true;
          };
        };

        fetches = {
          neofetch.enable = true;
          hyfetch.enable = true;
          fastfetch.enable = true;
        };

        utilities = {
          all = true;
          eza.enable = true;
          tmux.enable = true;
        };
      };

      system = {
#         users.enable = true; #Use default.
#         users.name = "localhost"; #Use default.
#         flakes = true; #Use default.
        terminals = {
          kitty.enable = true;
          termite.enable = true;
          alacritty.enable = true;
        };

        monitoring = {
          all = true;
          cli = {
            all = true;
            nvtop.enable = true;
            glances.enable = true;
            tops = {
              all = true;
              btop.enable = true;
              htop.enable = true;
              iotop.enable = true;
            };
          };
          gui = {
            all = true;
            mission-center.enable = true;
          };
        };
      };

      display = {

        servers = {
          xorg = {
#            enable = true;
          };
        };

        drivers = {
          enable = true;
          firmware = true;
          rocm = true;
          gpu = "nvidia";
          nvidia = {
            open = false;
            prime = true;
            version = "stable";
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:14:0:0";
          };
        };

        desktop-environments = {
          kde5 = {
            enable = false;
            gtk-config = false;
          };
          kde6.enable = true;
        };

        window-managers = {
          xmonad.enable = true;
        };

        login-managers = {
#          lightdm.enable = true;
          sddm.enable = true;
          sddm.wayland = true;
          gtkgreet.enable = true;
        };

        generic = {
          bars = {
            waybar = true;
            xmobar = true;
          };

          input = {
            libinput = true;
            flatInput = true;
            wacom = true;
          };

          util = {
            stalonetray = true;
            dunst = true;
            passthrough = true;
          };
        };

        fixes = {
          backlightFix = true;
          wacomFix = true;
          swaylockFix = true;
        };
      };

      gaming = {
        launchers = {
          steam.enable = true;
          lutris.enable = true;
          heroic.enable = true;
          bottles.enable = true;
        };
      };


      media = {
        audio = {
          pavucontrol.enable = true;
          music = {
            all = true;
            ncmpcpp.enable = true;
            mpc-cli.enable = true;
            mpd.enable = true;
          };
        };

        internet = {
          browsers = {
            firefox.enable = true;
            librewolf.enable = true;
            qutebrowser.enable = true;
            links2.enable = true;
          };

          vpn = {
            openvpn.enable = true;
            mullvad.enable = true;
          };

          downloading = {
            yt-dlp.enable = true;
          };
        };

        video = {
          viewers = {
            vlc.enable = true;
          };
        };

        image = {
          viewers = {
            feh.enable = true;
          };

          creation = {
            kolourpaint.enable = true;
            krita.enable = true;
            gimp.enable = true;
          };
        };

        screenshot = {
          all = true;
          gnome-screenshot.enable = true;
          scrot.enable = true;
          peek.enable = true;
        };

        encoding = {
          ffmpeg-full.enable = true;
        };

        productivity = {
          anytype.enable = true;
          freecad.enable = true;
          freecad-wayland.enable = true;
          libreoffice-fresh.enable = true;
          xournalpp.enable = true;
        };
      };
    };
  };
}
