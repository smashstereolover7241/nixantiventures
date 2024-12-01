{ lib, config, pkgs, ... }@inputs:

with lib;

let cfg = config.modules.home-manager.users;
in {
    options.modules.home-manager.users = {
        enable = mkEnableOption "Enables home-manager users, for now just yes or no";
        name = mkOption {
            description = "Username? You only get one tho.";
            type = types.str;
            default = "localhost";
        };
    };
    config = mkIf cfg.enable {
        home-manager.users.${cfg.name} = {
            home.username = cfg.name;
            home.stateVersion = "24.11"; #TODO: get this outta here
        };
    };
}
