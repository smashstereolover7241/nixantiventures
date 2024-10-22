{ lib, config, pkgs, home-manager, ... }:

with lib;

let cfg = config.shim.test;
in {
  options.shim.test.enable = mkEnableOption "Enables Within's vim config";

  config = mkIf cfg.enable {

  users = {
    users.amy = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "kvm" "networkmanager" "wheel" "audio" "video" "network" "input" ];
   #                 ++ (optional nm-enable "network-manager");
    };
    groups.localhost = {
      gid = 1000;
    };
  };
            home-manager.useGlobalPkgs = true;
            home-manager.users.amy = {
  home.username = "amy";
#  home.homeDirectory = "/home/amy";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
#  programs.home-manager.enable = true;
            };
  };
}
