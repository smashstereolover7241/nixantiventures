{ config, lib, pkgs, systemName, ... }:

{
    networking = {
        hostName = systemName;
        useDHCP = false;
    };

    nixpkgs.config.allowUnfree = true;

    time.timeZone = "Europe/Berlin";
    system.stateVersion = "21.05";
    # this is probably gonna get moved somewhere else
}
