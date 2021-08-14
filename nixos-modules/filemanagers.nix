{ config, lib, pkgs, ... }:
with lib;
let
  cfg = options.teletypeOne.filemanagers;
in {
  options.teletypeOne.filemanagers = {
    gui = mkEnableOption "Install graphical file managers";
    tui = mkEnableOption "Install tui file managers";
  };

  config = (mkMerge [
    (mkIf cfg.gui {
      services.gvfs.enable = true;
      environment.systemPackages = with pkgs; [cinnamon.nemo];
    })

    (mkIf cfg.tui {
      environment.systemPackages = with pkgs; [w3m ranger];
    })
  ]);

}
