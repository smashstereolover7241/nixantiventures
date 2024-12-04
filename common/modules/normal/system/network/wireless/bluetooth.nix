{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.network.wireless.bluetooth;
in
{
  options.modules.normal.system.network.wireless.bluetooth = {
    enable = mkEnableOption "Enable bluetooooth";
  };
  config = {
    hardware.bluetooth.enable = mkIf cfg.enable true;
  };
}
