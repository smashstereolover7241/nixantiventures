{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.theGrandUtilities;
in {
  options.teletyeOne.theGrandUtilities = {
    enable = mkEnableOption "Install TheGradUtilities (all for \"elderly people\")";
  };

  config = (mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ perl532Packages.EmailOutlookMessage xfce.ristretto ];
  });
}
