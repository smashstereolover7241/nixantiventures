{ lib, config, pkgs, ... }:

with lib;

let cfg = config.real.home-manager.users;
in {
    options.real.home-manager.users.enable = mkEnableOption "Enables home-manager users, for now just yes or no";
    config = mkIf cfg.enable {
            home-manager.useGlobalPkgs = true;
            home-manager.users.amy = {
                home.username = "amy";
                home.stateVersion = "24.11";
            };
        };
}
