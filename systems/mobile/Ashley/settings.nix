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

          sshd = {
            enable = true;
            passAuth = false;
            port = 7894;
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

          emulation = {
            all = true;
            qemu.enable = true;
            virtmanager.enable = true;
          };

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

            haskell = {
              all = true;
              cabal-install.enable = true;
              ghc.enable = true;
              digest.enable = true;
            };

            java = {
              all = true;
              openjdk11.enable = true;
              openjdk17.enable = true;
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
          remoteUnlock = {
            enable = true;
            port = 7777;
            netDrivers = "virtio_net";
            authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL4l4g4cP18QYi29pes7qXaWspme9u5fIM1m9RmxWCIP" ];
          };

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
              wdisplays.enable = true;
            };
          };

          xorg = {
#            enable = true;
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
          swayGoodies = true;
          xmonadGoodies = true;

          util = {
            notifications = {
              dunst.enable = true;
            };

            trays = {
              stalonetray.enable = true;
            };

            launchers = {
              rofi.enable = true;
              wofi.enable = true;
              gmrun.enable = true;
              nwg-drawer.enable = true;
            };

            bars = {
              waybar.enable = true;
              xmobar.enable = true;
            };

            brightness = {
              acpilight.enable = true;
            };

            passthrough.enable = true;
            wmctrl.enable = true;
          };
        };

        login-managers = {
#          lightdm.enable = true;
          sddm.enable = true;
          sddm.wayland = true;
          gtkgreet.enable = true;
        };

        generic = {

          input = {
            libinput = true;
            flatInput = true;
            wacom = true;
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
          generic = {
            steam.enable = true;
            lutris.enable = true;
            heroic.enable = true;
            bottles.enable = true;
          };

          minecraft = {
            prismlauncher.enable = true;
            lunar-client.enable = true;
            libFix = true;
          };
        };

        not-emulators = {
          wine-stable.enable = true;
          wine-wayland.enable = true;
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
            easyeffects.enable = false;
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
          android-studio.enable = true;
          adb.enable = true;
          scrcpy.enable = true;
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
            shadowsocks = {
              enable = true;
              port = 9999;
            };

            wireguardClient = {
              ip = "10.51.0.74";
              internalInterface = "wg0";
            };

            wireguardServer = {
              enable = true;
              listenPort = 51938;
              internalInterface = "wg0";
              externalInterface = "ens3";
              subNet = "51";
              peers = [
                { # Feel free to give a meaning full name
                  # Public key of the peer (not a file path).
                  publicKey = "FRhws1kkiUBQ91UGTMWzuPH5wUn9v16tfJFQnu7r4TM=";
                  # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
                  allowedIPs = [ "10.51.0.2/32" ];
                }
                { # ashley
                  publicKey = "L+rvPGrgJc5yjhD7mF+uCqKc7hRTkmWCcPftNpgbZVU=";
                  allowedIPs = [ "10.51.0.3/32" ];
                }
                { # p6
                  publicKey = "ksSAc7+W1/tlju7/h89U6eq4vo9mojLhY7PjbKc8WHQ=";
                  allowedIPs = [ "10.51.0.4/32" ];
                }
                { # luna
                  publicKey = "nJUPEKSCUr/oJjdAe36UIeHGlEJ+3TpE7pxOWkS0Yjg=";
                  allowedIPs = [ "10.51.0.5/32" ];
                }
                { # owo
                  publicKey = "bccaq3hnXCMNGRILykO225ezENYb9x0qB4AQArD0mXA=";
                  allowedIPs = [ "10.51.0.6/32" ];
                }
              ];
            };
          };

          downloading = {
            yt-dlp.enable = true;
          };
        };

        communication = {
          all = true;
          free = true;
          nonFree = true;
          messaging = {
            all = true;
            revolt-desktop.enable = true;
            element-desktop.enable = true;
            signal-desktop.enable = true;
            telegram-desktop.enable = true;
          };

          voice = {
            all = true;
            mumble.enable = true;
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
