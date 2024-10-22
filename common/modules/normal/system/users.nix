{ lib, config, pkgs, ... }:

with lib;

let cfg = config.real.normal.system.users;
in {
  options.real.normal.system.users.enable = mkEnableOption "Enables users, for now just yes or no";

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
            home.stateVersion = "24.11";
        };
    };
}
