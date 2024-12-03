{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.security.fprintd;
in
{
  options.modules.normal.system.security.fprintd = {
    enable = mkEnableOption "Enable fprintd";
  };
  config = {
    services.fprintd.enable = true;
  };
}
