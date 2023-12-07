{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.fonts;
in {
  options.teletypeOne.fonts = {
    firaCode = mkEnableOption "Install the firacode font.";
  };

  config = (mkMerge [
    (mkIf cfg.firaCode {
      fonts.packages = with pkgs; [fira-code];
    })
  ]);
}
