{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.terminals;
in {
  options.teletypeOne.terminals = {
    alacritty = mkEnableOption "Install alacritty.";
    termite = mkEnableOption "Install termite.";
  };

  config = (mkMerge [
    (mkIf (cfg.alacritty) {
      environment.systemPackages = with pkgs; [alacritty];
    })

    (mkIf (cfg.termite) {
      environment.systemPackages = with pkgs; [termite];
    })

  ]);
}
