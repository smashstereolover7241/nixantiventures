{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.theGrandUtilities;
in {
  options.teletypeOne.theGrandUtilities = {
    enable = mkEnableOption "Install TheGrandUtilities (all for \"elderly people\")";
  };

  config = (mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ perl532Packages.EmailOutlookMessage xfce.ristretto xfce.tumbler ];
  });
}
