{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.communication;
in {
  options.teletypeOne.communication = {
    free = mkEnableOption "Install free communication tools.";
    nonFree = mkEnableOption "Install nonfree communication tools.";
    bullshit = mkEnableOption "Install dumb communication tools.";
  };

  config = (mkMerge [
    (mkIf (cfg.free) {
      environment.systemPackages = with pkgs; [signal-desktop element-desktop thunderbird-78];
    })

    (mkIf (cfg.nonFree) {
      environment.systemPackages = with pkgs; [discord];
    })

    (mkIf (cfg.bullshit) {
      environment.systemPackages = with pkgs; [teams];
    })
  ]);
}
