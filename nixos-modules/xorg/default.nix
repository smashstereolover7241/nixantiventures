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
      type = types.enum ["modesetting" "nvidia"];
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
  xmonad = mkEnableOption "Enable xmonad";
  xmobar = mkEnableOption "Enable xmobar";
  lightdm = mkEnableOption "Enable lightdm";
  libinput = mkEnableOption "Enable libinput";

  };
  config = mkIf cfg.enable (mkMerge [
    {
      services.xserver = {
        enable = true;

        windowManager = mkIf cfg.xmonad {
          xmonad.enable = true;
          xmonad.enableContribAndExtras = true;
        };

        displayManager = mkIf cfg.xmonad {
          lightdm.enable = mkIf cfg.lightdm true;
          defaultSession = "none+xmonad";
        };

        environment.systemPackages = mkIf cfg.xmobar (with pkgs; [xmobar]);

      };
      hardware = {
        opengl.driSupport32Bit = true;
      };
    }


         (mkIf (cfg.libinput == true){
          services.xserver.libinput.enable = true;
        })

    (mkIf (cfg.gpu == "nvidia") {
      services.xserver.videoDrivers = ["nvidia"];
      environment.systemPackages = mkIf (cfg.nvidia.prime)
        [ nvidia-offload pkgs.libglvnd ];

      hardware.nvidia.prime = mkIf cfg.nvidia.prime {
        offload.enable = true;

        intelBusId = cfg.nvidia.intelBusId;
        nvidiaBusId = cfg.nvidia.nvidiaBusId;
      };
    })
  ]);
}
