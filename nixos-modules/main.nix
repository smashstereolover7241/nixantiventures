{ config, lib, ... }:
with lib;
let
  nm-enable = config.networking.networkmanager.enable;
in {
  users = {
    users.localhost = {
      isNormalUser = true;

      uid = 1000;

      extraGroups = [ "wheel" "audio" ]
                    ++ (optional nm-enable "network-manager");
    };
    groups.localhost = {
      gid = 1000;
    };
  };
}
