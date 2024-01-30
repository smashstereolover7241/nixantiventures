{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.fonts;
in {
  options.teletypeOne.fonts = {
    firaCode = mkEnableOption "Install the firacode font.";
    all_the_icons = mkEnableOption "Install the all-the-icons (emacs) font.";
  };

  config = (mkMerge [
    (mkIf cfg.firaCode {
      fonts.packages = with pkgs; [ fira-code ];
    })

    (mkIf cfg.firaCode {
      fonts.packages = with pkgs; [ emacs-all-the-icons-fonts ];
    })

  ]);
}
