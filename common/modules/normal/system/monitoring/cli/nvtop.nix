{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.monitoring.cli.nvtop;
in
{
  options.modules.normal.system.monitoring.cli.nvtop = {
    enable = mkEnableOption "Enable nvtop";
  };
  config = {
    environment.systemPackages = mkIf cfg.enable [ pkgs.nvtopPackages.full ];
  };
}
