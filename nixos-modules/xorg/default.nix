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
      type = types.enum ["modesetting" "nvidia" "intel" "amd" "ati" "radeon" "null" "intelAccelerated"];
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
    intelAccelerated = mkOption {
      description = "Intel drivers, with opengl etc.";
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
    wacomFix = mkEnableOption "Fix wacom (X200T)";
    backlightFix = mkEnableOption "fix backlight, maybe";
    stalone = mkEnableOption "install stalonetray";
    firmware = mkEnableOption "install additional firmware";
    pass = mkEnableOption "Gpu is passed thru";
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

    (mkIf (cfg.firmware == true){
      environment.systemPackages = (with pkgs; [linux-firmware]);
      hardware.enableAllFirmware = true;
      hardware.opengl.extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
      hardware.opengl.driSupport = true;
      hardware.enableRedistributableFirmware = true;
      hardware.opengl.enable = true;
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

# this shouldnt be here, it's also broken....      environment.systemPackages = [ pkgs.easystroke ];
      # wtf??? environment.systemPackages = [ pkgs.easystroke  pkgs.mfcj4335dwlpr ];
    })
    (mkIf cfg.wacom {
      services.xserver.wacom.enable = true;
    })

    (mkIf cfg.wacomFix {
     #couldn't get it working with a single service, so 2 it is 
     systemd.services.inputattach = {
        wantedBy = [ "multi-user.target" ];
        description = "inputattach thingy";
        serviceConfig = {
          Type = "simple";
#	  ExecStartPre="/run/current-system/sw/bin/sleep 5"; # takes a moment to show up
	  ExecStart="/run/current-system/sw/bin/isdv4-serial-inputattach /dev/ttyS0";
        };
      };
     #Need to reattach the device after every suspend
     systemd.services.inputreattach = {
        wantedBy = [ "suspend.target" ];
        after = [ "suspend.target" ];
        description = "inputattach thingy";
        serviceConfig = {
          Type = "simple";
	  ExecStartPre="/run/current-system/sw/bin/sleep 5"; # takes a moment to show up
	  ExecStart="/run/current-system/sw/bin/isdv4-serial-inputattach /dev/ttyS0";
        };
      };

    })

    (mkIf cfg.pass {
      services.xserver.extraConfig = ''
        Section "Device"
        Identifier "YAY"
        BusID "PCI:0:6:0"
        EndSection
      '';
    })

    (mkIf (cfg.gpu == "nvidia") {
      services.xserver.videoDrivers = ["nvidia"];
      hardware.opengl.enable = true;

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

    (mkIf (cfg.stalone) {
      environment.systemPackages = [ pkgs.stalonetray ];
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

    (mkIf (cfg.gpu == "intelAccelerated") {
      services.xserver.videoDrivers = ["intel"];
      nixpkgs.config.packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
      };
      hardware.opengl = {
        enable = true;
        driSupport = true;
        extraPackages = with pkgs; [
          intel-media-driver # LIBVA_DRIVER_NAME=iHD
          vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
    })
  ]);
}
