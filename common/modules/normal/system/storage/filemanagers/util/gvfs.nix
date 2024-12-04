{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.storage.filemanagers.util.gvfs;
in
{
  options.modules.normal.system.storage.filemanagers.util.gvfs = {
    enable = mkEnableOption "Enable gvfs so yes";
  };

  config = mkIf cfg.enable {
    services.gvfs.enable = true;
  };
}
