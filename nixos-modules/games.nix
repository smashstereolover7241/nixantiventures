{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.games;
in {
  options.teletypeOne.games = {
    steam = mkEnableOption "Enable steam";
    lutris = mkEnableOption "Enable lutris";
    bottles = mkEnableOption "Enable bottles";
    heroic = mkEnableOption "Install heroic launcher";
    minecraft = mkEnableOption "Install minecraft launcher";
    minecraftLibFix = mkEnableOption "Install some random libraries required to launch some modpacks";
  };

  config = (mkMerge [
    (mkIf cfg.steam {
      programs.steam.enable = true;
      hardware.opengl.driSupport32Bit = true;
    })

    (mkIf cfg.lutris {
      environment.systemPackages = with pkgs; [lutris cacert];
    })

    (mkIf cfg.heroic {
      environment.systemPackages = with pkgs; [heroic];
    })

    (mkIf cfg.bottles {
      environment.systemPackages = with pkgs; [bottles];
    })

    (mkIf cfg.minecraft {
      environment.systemPackages = with pkgs; [lunar-client prismlauncher];
    })

    (mkIf cfg.minecraftLibFix {
      environment.systemPackages = with pkgs; [xorg.libXxf86vm xorg.libXxf86dga xorg.libXxf86misc];
    })
  ]);
}
