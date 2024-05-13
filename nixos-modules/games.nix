{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.games;
in {
  options.teletypeOne.games = {
    steam = mkEnableOption "Enable steam";
    minecraft = mkEnableOption "Install minecraft launcher";
    minecraftLibFix = mkEnableOption "Install some random libraries required to launch some modpacks";
  };

  config = (mkMerge [
    (mkIf cfg.steam {
      programs.steam.enable = true;
      environment.systemPackages = with pkgs; [lutris cacert];
      hardware.opengl.driSupport32Bit = true;
    })

    (mkIf cfg.minecraft {
      environment.systemPackages = with pkgs; [lunar-client prismlauncher];
    })
    (mkIf cfg.minecraftLibFix {
      environment.systemPackages = with pkgs; [xorg.libXxf86vm xorg.libXxf86dga xorg.libXxf86misc];
    })
  ]);
}
