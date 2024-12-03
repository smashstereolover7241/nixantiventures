{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.security.gpg;
in
{
  options.modules.normal.system.security.gpg = {
    enable = mkEnableOption "Enable gpg";
  };
  config = {
    environment.systemPackages = with pkgs; [gnupg pinentry pinentry-gtk2 pinentry-curses];
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gtk2;
      enableSSHSupport = true;
    };
  };
}

#TODO: take a look if creating more options is required
