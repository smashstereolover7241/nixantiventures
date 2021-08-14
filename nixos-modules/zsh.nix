{ config, lib, pkgs, ... }:
with lib;
let
  cfc = config.teletypeOne.zsh;
in {
  options.teletypeOne.terminals = {
    enabled = mkEnableOption "Install zsh";
    ohMy = mkEnableOption "Install ohmyzsh";
  };

  config = (mkMerge [
    (mkIf (cfg.enabled) {
      programs.zsh.syntaxHightlighting.enable = true;
      users.localhost.shell = pkgs.zsh;
    })
    (mkIf (cfg.ohMy) {
      programs.zsh.ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
  };
    })
  ]);
}
