{ config, lib, pkgs, ... }:
with lib;
let
    cfg = config.real.normal.cli.shell.zsh;
in {
    options.real.normal.cli.shell.zsh = {
        enable = mkEnableOption "Install zsh";
        ohMy = mkEnableOption "Install ohmyzsh";
    };

    config = (mkMerge [
        (mkIf (cfg.enable) {
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