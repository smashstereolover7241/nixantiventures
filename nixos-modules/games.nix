{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.games;
in {
  options.teletypeOne.games = {
    steam = mkEnableOption "Enable steam";
    minecraft = mkEnableOption "Install minecraft launcher";
  };

  config = (mkMerge [
    (mkIf cfg.steam {
      programs.steam.enable = true;
    })

    (mkIf cfg.minecraft {
      environment.systemPackages = with pkgs; [minecraft multimc];
    })
  ]);
}
