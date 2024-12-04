{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.network.networkmanager;
in
{
  options.modules.normal.system.network.networkmanager = {
    enable = mkEnableOption "Enable networkmanager";
  };
  config = {
    networking.networkmanager.enable = mkIf cfg.enable true;
  };
}
