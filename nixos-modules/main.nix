{ config, lib, ... }:
with lib;
let
  nm-enable = config.networking.networkmanager.enable;
in {
  users = {
    users.localhost = {
      isNormalUser = true;

      uid = 1000;

      extraGroups = [ "wheel" "audio" "video" "network"]
                    ++ (optional nm-enable "network-manager");
    };
    groups.localhost = {
      gid = 1000;
    };
  };
}
