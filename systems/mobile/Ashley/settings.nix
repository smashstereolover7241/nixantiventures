{ config, lib, pkgs, ... }@inputs:
let
    rootPath = (lib.filesystem.locateDominatingFile "flake.nix" ./.).path; # this is severly stupid, couldn't find a better way tho;
in
{
  imports = [ (rootPath + "/common/shim.nix") ];
  shim = {
    enable = true;
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
      };
      system = {
#         users.enable = true; #Use default.
#         users.name = "localhost"; #Use default.
#         flakes = true; #Use default.
      };
      display = {
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
          lightdm.enable = false;
          sddm.enable = false;
          gtkgreet.enable = true;
        };

        generic = {
          bars = {
            waybar = true;
            xmobar = true;
          };
          util = {
            stalonetray = true;
            dunst = true;
            passthrough = true;
          };
        };
      };
    };
  };
}
