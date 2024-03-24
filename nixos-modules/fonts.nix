{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.fonts;
in {
  options.teletypeOne.fonts = {
    firaCode = mkEnableOption "Install the firacode font.";
    all_the_icons = mkEnableOption "Install the all-the-icons (emacs) font.";
    ricing_fonts = mkEnableOption "Install a bunch of other fonts.";
  };

  config = (mkMerge [
    (mkIf cfg.firaCode {
      fonts.packages = with pkgs; [ fira-code ];
    })

    (mkIf cfg.all_the_icons {
      fonts.packages = with pkgs; [ emacs-all-the-icons-fonts ];
    })

    (mkIf cfg.ricing_fonts {
      fonts.packages = with pkgs;
        [
          dejavu_fonts
          font-awesome
          fira-code-symbols
          (iosevka-bin.override { variant = "Aile"; })
          material-design-icons
          #Monolisa
          (nerdfonts.override { fonts = [ "FiraMono" "JetBrainsMono" ]; })
          noto-fonts
          powerline-symbols
          # sf-mono-liga-bin
        ];
    })
  ]);
}
