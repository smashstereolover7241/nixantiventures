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
          pv.enable = true;
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

        compute = {
          all = true;
          compression = {
            all = true;
            pigz.enable = true;
            unzip.enable = true;
            zlib.enable = true;
          };

          lang = {
            all = true;
            c = {
              all = true;
              cmake.enable = true;
              ninja.enable = true;
              gcc.enable = true;
              gnumake.enable = true;
              pkg-config.enable = true;
            };
          };

          database = {
            all = true;
            sqlite.enable = true;
          };
        };

        storage = {
          sync = {
            nextcloud-client.enable = true;
          };

          partition = {
            gui = {
              gparted.enable = true;
            };

          };

          hardware = {
            hdparm.enable = true;
            libatasmart.enable = true;
          };

          managing = {
            ncdu.enable = true;
            meld.enable = true;
          };
        };

        security = {
          gpg.enable = true;
          keepassxc.enable = true;
          betterlockscreen.enable = true;
          policykit.enable = true;
          fprintd.enable = true;
        };
      };

      display = {
        servers = {
          xorg = {
#            enable = true;
            utilities = {
              xclip.enable = true;
              xdotool.enable = true;
              xwininfo.enable = true;
            };
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

          programming = {
            all = true;
            git.enable = true;
          };

          text-editors = {
            gui = {
              geany.enable = true;
              emacs.enable = true;
              emacsGoodies = true;
            };

            cli = {
              neovim.enable = true;
              vim.enable = true;
            };
          };
        };
      };
    };
  };
}
