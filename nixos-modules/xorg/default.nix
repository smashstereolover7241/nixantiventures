{ config, lib, pkgs, ... }:

with lib;
let
  xserver-enable = config.services.xserver.enable;
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
  cfg = config.teletypeOne.xorg;
in {
  options.teletypeOne.xorg = {
    enable = mkEnableOption "Xorg so graphical can happen";
    gpu = mkOption {
      description = "Which gpu?";
      type = types.enum ["modesetting" "nvidia" "intel" "amd" "ati" "radeon" "null"];
    };
    nvidia = mkOption {
      description = "Nvidia yaaay";
      type = types.submodule {
        options = {
          prime = mkEnableOption "Nvidia PRIME";

          intelBusId = mkOption {
            type = types.str;
            default = "";
          };
          nvidiaBusId = mkOption {
            type = types.str;
            default = "";
          };

        };
      };
      default = {};
    };
    modesetting = mkOption {
      description = "Intel modesetting, yay?";
    };

    intel = mkOption {
      description = "Intel normal drivers";
    };

    amd = mkOption {
      description = "Amd drivers";
    };
    ati = mkOption {
      description = "Ati drivers";
    };
    radeon = mkOption {
      description = "radeon drivers";
    };
    null = mkOption {
      description = "Disable Video drivers";
    };


  xmonad = mkEnableOption "Enable xmonad";
  kde = mkEnableOption "Enable kde";
  xmobar = mkEnableOption "Enable xmobar";
  dunst = mkEnableOption "Enable dunst";
  lightdm = mkEnableOption "Enable lightdm";
  sddm = mkEnableOption "Enable sddm";
  libinput = mkEnableOption "Enable libinput";
  flatInput = mkEnableOption "Add extra config for non-accelerated mouse input.";
  wacom = mkEnableOption "Install wacom drivers";
  backlightFix = mkEnableOption "fix backlight, maybe";
  };
  config = mkIf cfg.enable (mkMerge [
    {
      services.xserver = {
        enable = true;
        desktopManager.plasma5.enable = mkIf cfg.kde (true);
        windowManager = mkIf cfg.xmonad {
          xmonad.enable = true;
          xmonad.enableContribAndExtras = true;
        };

        displayManager = mkIf cfg.xmonad {
          lightdm.enable = mkIf cfg.lightdm true;
          sddm.enable = mkIf cfg.sddm true;
          defaultSession = "none+xmonad";
        };

      };

        environment.systemPackages = mkIf cfg.xmobar (with pkgs; [xmobar]);

      hardware = {
        opengl.driSupport32Bit = true;
      };
    }

    (mkIf cfg.kde {
      environment.systemPackages = (with pkgs; [kde-gtk-config]);
    })
         (mkIf (cfg.dunst == true){
           environment.systemPackages = (with pkgs; [xmobar]);
        })

         (mkIf (cfg.libinput == true){
          services.xserver.libinput.enable = true;
        })

         (mkIf cfg.flatInput {
             services.xserver.extraConfig = ''
    Section "InputClass"
          Identifier "My Mouse"
          MatchIsPointer "yes"
          Option "AccelerationProfile" "-1"
          Option "AccelerationScheme" "none"
          Option "AccelSpeed" "-1"
    EndSection
'';
        })

         (mkIf cfg.backlightFix {
             services.xserver.extraConfig = ''
Section "Device"
    Identifier  "Intel Graphics" 
    Driver      "intel"
    Option      "Backlight"  "intel_backlight"
EndSection

'';
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';
 
         environment.systemPackages = [ pkgs.easystroke ];
        })
    (mkIf cfg.wacom {
      services.xserver.wacom.enable = true;
    })

    (mkIf (cfg.gpu == "nvidia") {
      services.xserver.videoDrivers = ["nvidia" "modesetting"];
      environment.systemPackages = mkIf (cfg.nvidia.prime)
        [ nvidia-offload pkgs.libglvnd ];

      hardware.nvidia.prime = mkIf cfg.nvidia.prime {
        offload.enable = true;

        intelBusId = cfg.nvidia.intelBusId;
        nvidiaBusId = cfg.nvidia.nvidiaBusId;
      };
    })
    (mkIf (cfg.gpu == "modesetting") {
      services.xserver.videoDrivers = ["modesetting"];
    })

    (mkIf (cfg.gpu == "intel") {
      services.xserver.videoDrivers = ["intel"];
    })

    (mkIf (cfg.gpu == "amd") {
      services.xserver.videoDrivers = ["amdpgu"];
    })

    (mkIf (cfg.gpu == "ati") {
      services.xserver.videoDrivers = ["ati"];
    })

    (mkIf (cfg.gpu == "radeon") {
      services.xserver.videoDrivers = ["radeon"];
    })
    (mkIf (cfg.gpu == "null") {
    })
  ]);
}
