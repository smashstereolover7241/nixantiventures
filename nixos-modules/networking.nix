{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.networking;
in {
  options.teletyepeOne.networking = {
    networkManager = mkEnableOption "Nmtui?";
    bluetooth = mkEnableOption "Is Bluetooth card installed?";
  };

  config = {
    networking.networkmanager.enable = mkIf cfg.networkManager true;
    hardware.bluetooth.enable = mkIf cfg.bluetooth true;
  };
}
