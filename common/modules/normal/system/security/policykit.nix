{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.security.policykit;
in
{
  options.modules.normal.system.security.policykit = {
    enable = mkEnableOption "Enable lxqt policykit";
  };
  config = {
    environment.systemPackages = with pkgs; [ lxqt.lxqt-policykit ];
  };
}

#TODO: take a look if creating more options is required
