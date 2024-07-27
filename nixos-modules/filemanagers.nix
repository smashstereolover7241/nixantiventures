{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.filemanagers;
in {
  options.teletypeOne.filemanagers = {
    gui = mkEnableOption "Install graphical file managers";
    tui = mkEnableOption "Install tui file managers";
    smb = mkEnableOption "Install smb tools.";
  };

  config = (mkMerge [
    (mkIf cfg.gui {
      services.gvfs.enable = true;
      environment.systemPackages = with pkgs; [nemo];
    })
    (mkIf cfg.smb {
      services.gvfs = {
        enable = true;
        package = lib.mkForce pkgs.gnome.gvfs;
      };
      teletypeOne.util.polkit = true; # a polkit is required to authenticate.
    })

    (mkIf cfg.tui {
      environment.systemPackages = with pkgs; [w3m ranger];
    })
  ]);

}
