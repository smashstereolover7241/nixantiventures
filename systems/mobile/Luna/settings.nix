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

          util = {
            direnv.enable = true;
            nix-direnv.enable = true;
          };
        };

        fetches = {
          neofetch.enable = true;
          hyfetch.enable = true;
          fastfetch.enable = true;
        };

        util = {
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
        network = {
          networkmanager.enable = true;
          wireless = {
            bluetooth.enable = true;
          };
        };

        terminals = {
          kitty.enable = true;
          termite.enable = false;
          alacritty.enable = true;
        };

        monitoring = {
          all = false;
          cli = {
            all = false;
            nvtop.enable = false;
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
          all = false;
          compression = {
            all = true;
            pigz.enable = true;
            unzip.enable = true;
            zlib.enable = true;
          };

          lang = {
            all = false;
            c = {
              all = true;
              cmake.enable = true;
              ninja.enable = true;
              gcc.enable = true;
              gnumake.enable = true;
              pkg-config.enable = true;
            };

            haskell = {
              all = true;
              cabal-install.enable = true;
              ghc.enable = true;
              digest.enable = true;
            };

            java = {
              all = false;
              openjdk11.enable = false;
              openjdk17.enable = false;
            };

            util = {
              all = true;
              libtool.enable = true;
            };
          };

          database = {
            all = true;
            sqlite.enable = true;
          };
        };

        storage = {
          filemanagers = {
            all = true;
            gui = {
              all = true;
              nemo.enable = true;
            };

            tui = {
              all = true;
              w3m.enable = true;
              ranger.enable = true;
            };

            util = {
              all = true;
              gvfs.enable = true;
              smb.enable = true;
            };
          };

          sync = {
            nextcloud-client.enable = false;
          };

          partition = {
            gui = {
              gparted.enable = false;
            };

          };

          hardware = {
            hdparm.enable = true;
            libatasmart.enable = true;
          };

          managing = {
            ncdu.enable = true;
            meld.enable = false;
          };
        };

        security = {
          gpg.enable = true;
          keepassxc.enable = true;
          betterlockscreen.enable = false;
          policykit.enable = true;
          fprintd.enable = false;
        };
      };

      display = {
        theming = {
          all = true;
          settings = {
            all = true;
            lxappearance.enable = true;
          };

          themes = {
            all = true;
            color = {
              all = true;
              arc-theme.enable = true;
            };

            icon = {
              all = true;
              papirus-icon-theme.enable = true;
            };
          };

          fonts = {
            all = true;
            emacs-all-the-icons-fonts.enable = true;
            ricing_fonts = true;
            fira-code.enable = true;
            powerline-symbols.enable = true;
            dejavu_fonts.enable = true;
            iosevka.enable = true;
            material-design-icons.enable = true;
            nerdfonts.enable = true;
            font-awesome.enable = true;
            noto-fonts.enable = true;
            fira-code-symbols.enable = true;
          };
        };

        servers = {
          wayland = {
            util = {
              wdisplays.enable = false;
            };
          };

          xorg = {
            enable = true;
            util = {
              xclip.enable = true;
              xdotool.enable = true;
              xwininfo.enable = true;
              xkill.enable = true;
              arandr.enable = true;
              libXxf86dga.enable = true;
              libXxf86vm.enable = true;
              libXxf86misc.enable = true;
            };
          };
        };

        drivers = {
          enable = true;
          firmware = true;
          rocm = false;
          gpu = "modesetting";
        };

        desktop-environments = {
          kde5 = {
            enable = false;
            gtk-config = false;
          };
          kde6.enable = true;
        };

        window-managers = {
          xmonad.enable = false;
          swayGoodies = false;
          xmonadGoodies = false;

          util = {
            notifications = {
              dunst.enable = false;
            };

            trays = {
              stalonetray.enable = false;
            };

            launchers = {
              rofi.enable = false;
              wofi.enable = false;
              gmrun.enable = false;
              nwg-drawer.enable = false;
            };

            bars = {
              waybar.enable = false;
              xmobar.enable = false;
            };

            brightness = {
              acpilight.enable = false;
            };

            passthrough.enable = false;
            wmctrl.enable = false;
          };
        };

        login-managers = {
          lightdm.enable = true;
          sddm.enable = false;
          sddm.wayland = false;
          gtkgreet.enable = false;
        };

        generic = {

          input = {
            libinput = true;
            flatInput = true;
            wacom = false;
          };
        };

        fixes = {
          backlightFix = true;
          wacomFix = false;
          swaylockFix = false;
        };
      };

      gaming = {
        launchers = {
          generic = {
            steam.enable = false;
            lutris.enable = false;
            heroic.enable = false;
            bottles.enable = false;
          };

          minecraft = {
            prismlauncher.enable = false;
            lunar-client.enable = false;
            libFix = false;
          };
        };

        not-emulators = {
          wine-stable.enable = false;
          wine-wayland.enable = false;
        };
      };


      media = {
        audio = {
          servers = {
            pipewire.enable = true;
            pulseaudio.enable = false;
            pulseaudio.bluetooth = false;
          };

          music = {
            all = true;
            ncmpcpp.enable = true;
            mpc-cli.enable = true;
            mpd.enable = true;
          };

          effects = {
            easyeffects.enable = true;
          };

          control = {
            pavucontrol.enable = true;
            playerctl.enable = true;
          };

          util = {
            alsa-utils.enable = true;
          };
        };

        android = {
          android-studio.enable = false;
          adb.enable = false;
          scrcpy.enable = false;
        };

        internet = {
          browsers = {
            firefox.enable = true;
            librewolf.enable = true;
            qutebrowser.enable = true;
            links2.enable = true;
          };

          vpn = {
            openvpn.enable = false;
            mullvad.enable = false;

            wireguardClient = {
              enable = false; #l8 TODO
              ip = "10.51.0.74";
              internalInterface = "wg0";
            };
          };

          downloading = {
            yt-dlp.enable = true;
          };
        };

        communication = {
          all = false;
          free = false;
          nonFree = false;
          messaging = {
            all = true;
            revolt-desktop.enable = true;
            element-desktop.enable = true;
            signal-desktop.enable = true;
            telegram-desktop.enable = false;
          };

          voice = {
            all = false;
            mumble.enable = false;
          };

          mail = {
            all = true;
            thunderbird.enable = true;
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
            krita.enable = false;
            gimp.enable = false;
          };
        };

        screenshot = {
          all = false;
          gnome-screenshot.enable = false;
          scrot.enable = false;
          peek.enable = true;
        };

        encoding = {
          ffmpeg-full.enable = true;
        };

        productivity = {
          knowledge = {
            anytype.enable = true;
            xournalpp.enable = false;
          };

          cad = {
            freecad.enable = true;
            freecad-wayland.enable = false;
          };

          printing = {
            slicers = {
              prusa-slicer.enable = false;
              orca-slicer.enable = false;
            };
          };

          office = {
            libreoffice-fresh.enable = false;
          };

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
