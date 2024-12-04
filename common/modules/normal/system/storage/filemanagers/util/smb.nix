{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.storage.filemanagers.util.smb;
in
{
  options.modules.normal.system.storage.filemanagers.util.smb = {
    enable = mkEnableOption "Enable gvfs so yes";
  };

  config = mkIf cfg.enable {
    services.gvfs = {
      package = lib.mkForce pkgs.gnome.gvfs;
    };
  };
}
