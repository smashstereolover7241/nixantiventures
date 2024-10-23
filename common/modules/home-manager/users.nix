{ lib, config, pkgs, ... }@inputs:

with lib;

let cfg = config.real.home-manager.users;
in {
    options.real.home-manager.users = {
        enable = mkEnableOption "Enables home-manager users, for now just yes or no";
        name = mkOption {
            description = "Username? You only get one tho.";
            type = types.str;
        };
    };
    config = mkIf cfg.enable {
        home-manager.extraSpecialArgs = { inherit inputs;};
        home-manager.useGlobalPkgs = true;
        home-manager.users.${cfg.name} = {
            home.username = cfg.name;
            home.stateVersion = "24.11";
        };
    };
}
