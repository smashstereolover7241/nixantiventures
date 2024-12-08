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
        };

        monitoring = {
          cli = {
            glances.enable = true;
            tops = {
              all = true;
              btop.enable = true;
              htop.enable = true;
              iotop.enable = true;
            };
          };
        };

        tweaks = {
          power = {
            lidClose = {
              enable = true;
              handle = "ignore";
            };
          };
        };

        containers = {
          docker.enable = true;
          docker.storageDriver = "zfs";
        };

        compute = {
          compression = {
            all = true;
            pigz.enable = true;
            unzip.enable = true;
            zlib.enable = true;
          };
        };

        storage = {
          remoteUnlock = {
            enable = false;
            port = 7777;
            netDrivers = "virtio_net";
            authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL4l4g4cP18QYi29pes7qXaWspme9u5fIM1m9RmxWCIP" ];
          };

          filemanagers = {
            tui = {
              all = true;
              w3m.enable = true;
              ranger.enable = true;
            };
          };

          hardware = {
            hdparm.enable = true;
            libatasmart.enable = true;
          };

          managing = {
            ncdu.enable = true;
          };
        };
      };

      media = {
        internet = {
          browsers = {
            links2.enable = true;
          };

          vpn = {
            wireguardClient = {
              enable = true;
              ip = "10.51.0.10";
              internalInterface = "wg0";
            };

            wireguardServer.enable = false;
          };

          downloading = {
            yt-dlp.enable = true;
          };
        };

        encoding = {
          ffmpeg-full.enable = true;
        };

        productivity = {
          programming = {
            git.enable = true;
          };

          text-editors = {
            cli = {
              neovim.enable = true;
              vim.enable = false;
            };
          };
        };
      };
    };
  };
}
