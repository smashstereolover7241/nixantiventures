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
      users.enable = false;
#      users.name = "localhost"; #Use default
      cli = {
        shell = {
          zsh.enable = false;
        };
#        zsh.username = "localhost"; #Use default
      };
    };
    normal = {
      cli = {
        shell = {
          zsh = {
            enable = false;
          };

          sshd = {
            enable = true;
            passAuth = false;
            port = 1529;
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
         users.enable = true; #this now defaults to false
#         users.name = "localhost"; #Use default.
#         flakes = true; #Use default.
        network = {
          networkmanager.enable = true;
          wireless = {
            bluetooth.enable = false;
          };
        };

        monitoring = {
          all = false;
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
        };

        containers = {
          docker.enable = true;
          docker.storageDriver = "zfs";
        };

        compute = {
          all = false;

          compression = {
            all = true;
            pigz.enable = true;
            unzip.enable = true;
            zlib.enable = true;
          };
        };

        storage = {
          remoteUnlock = {
            enable = true;
            port = 9875;
            netDrivers =  [ "virtio_net" ];
            authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL4l4g4cP18QYi29pes7qXaWspme9u5fIM1m9RmxWCIP" ];
          };

          filemanagers = {
            all = false;
            tui = {
              all = true;
              w3m.enable = true;
              ranger.enable = true;
            };
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
            shadowsocks = {
              enable = true;
              port = 8390;
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
        };

        productivity = {
          programming = {
            git.enable = true;
          };

          text-editors = {
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
