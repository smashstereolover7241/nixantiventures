{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.theGrandUtilities;
in {
  options.teletypeOne.theGrandUtilities = {
    enable = mkEnableOption "Install TheGrandUtilities (all for \"elderly people\")";
  };

  config = (mkIf cfg.enable {
      services.printing.drivers = [ pkgs.mfcj4335dwlpr pkgs.gutenprint pkgs.mfcj470dw-cupswrapper pkgs.mfcj6510dw-cupswrapper pkgs.brlaser pkgs.cnijfilter2 ];
      environment.systemPackages = with pkgs; [ firefox links2 vlc feh peek xfce.ristretto xfce.tumbler tigervnc ];
  });
}
