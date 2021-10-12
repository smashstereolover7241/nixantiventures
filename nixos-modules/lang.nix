{ config, lib, pkgs, ... }:
with lib;
{
  cfg = config.teletypeOne.lang;
}
in {
  options.teletypeOne.lang = {
    rust = mkEnableOption "Install rust language compiler and utilities"
  };
  config = (mkMerge [
    (mkIf cfg.rust {
      environment.systemPackages = with pkgs; [rust];
    })
  ]);
}
