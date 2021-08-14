{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.zsh;
in {
  options.teletypeOne.zsh = {
    enabled = mkEnableOption "Install zsh";
    ohMy = mkEnableOption "Install ohmyzsh";
  };

  config = (mkMerge [
    (mkIf (cfg.enabled) {
      programs.zsh.enable = true;
      users.users.localhost.shell = pkgs.zsh;
    })
    (mkIf (cfg.ohMy) {
      programs.zsh.ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
  };
    })
  ]);
}
