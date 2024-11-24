{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.real.normal.display.drivers ;
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    e}xport __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  options.real.normal.display.drivers = {
    enable = mkEnableOption "Enable custom drivers";
    firmware = mkEnableOption "install additional firmware";
    rocm = mkEnableOption "install amd rocm";
    gpu = mkOption {
      description = "Which gpu?";
      type = types.enum ["modesetting" "nvidia" "nouveau" "intel" "amd" "ati" "radeon" "intelAccelerated" "null" "none" ""];
    };
    nvidia = mkOption {
      description = "Novideo drivers";
      type = types.submodule {
        options = {
          open = mkEnableOption "The open source nvidia drivers";
          prime = mkEnableOption "Nvidia PRIME";
          version = mkOption {
            description = "What version of the drivers to use. Defaults to stable.";
            type = types.str;
          };
          intelBusId = mkOption {
            type = types.str;
          };
          nvidiaBusId = mkOption {
            type = types.str;
          };
        };
      };
      default = {};
    };
  };

  config = mkIf cfg.enable (mkMerge [

    (mkIf cfg.firmware {
      environment.systemPackages = (with pkgs; [linux-firmware]);
      hardware.enableAllFirmware = true;
      hardware.enableRedistributableFirmware = true;
      hardware.graphics.enable = true;
    })

    (mkIf cfg.rocm {
      hardware.graphics.extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    })

    (mkIf (cfg.gpu == "nvidia") {
      services.xserver.videoDrivers = ["nvidia"];
      hardware.nvidia.open = cfg.nvidia.open;
      hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.${cfg.nvidia.version};
      environment.systemPackages = mkIf (cfg.nvidia.prime) [ nvidia-offload pkgs.libglvnd ];
      hardware.nvidia.prime = mkIf cfg.nvidia.prime {
        offload.enable = true;
        intelBusId = cfg.nvidia.intelBusId;
        nvidiaBusId = cfg.nvidia.nvidiaBusId;
      };
    })

    # all of these we can just pass through without special changes
    (mkIf (cfg.gpu == "intel" || cfg.gpu == "modesetting" || cfg.gpu == "amd" || cfg.gpu == "nouveau" || cfg.gpu == "ati" || cfg.gpu == "radeon" ){
      services.xserver.videoDrivers = cfg.gpu;
    })

    (mkIf (cfg.gpu == "null" || cfg.gpu == "" || cfg.gpu == "none") {
      # does nothing, just here in case doing changes for nothing are required
    })

    (mkIf (cfg.gpu == "intelAccelerated") {
      services.xserver.videoDrivers = ["intel"];
      nixpkgs.config.packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      };
      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver # LIBVA_DRIVER_NAME=iHD
          vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
          # we install both I guess?
          libvdpau-va-gl
          vaapiVdpau
        ];
      };
    })
  ]);
}
