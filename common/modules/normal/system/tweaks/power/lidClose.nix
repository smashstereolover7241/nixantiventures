{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.tweaks.power.lidClose;
in
{
  options.modules.normal.system.tweaks.power.lidClose = {
    enable = mkEnableOption "change lidClose handle";
    handle = mkOption {
      description = "what to do on lid close";
      type = types.str;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    services.logind.lidSwitch = cfg.handle;
  };
}
