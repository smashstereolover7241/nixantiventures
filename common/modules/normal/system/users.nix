{ lib, config, pkgs, ... }:

with lib;

let cfg = config.modules.normal.system.users;
in {
    options.modules.normal.system.users = {
        enable = mkEnableOption "Enables users";
        name = mkOption {
            description = "Username? You only get one tho.";
            type = types.str;
            default = "localhost";
        };
    };
    config = mkIf cfg.enable {
        users = {
            users.${cfg.name} = {
                isNormalUser = true;
                uid = 1000;
                extraGroups = [ "kvm" "networkmanager" "wheel" "audio" "video" "network" "input" ];
                #                 ++ (optional nm-enable "network-manager");
            };
            groups.${cfg.name} = {
                gid = 1000;
            };
        };
    };
}
