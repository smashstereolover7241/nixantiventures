{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.system.containers.docker;
in
{
  options.modules.normal.system.containers.docker = {
    enable = mkEnableOption "hey it's the docker thing";
    storageDriver = mkOption {
      description = "which storage driver to use";
      type = types.str;
      default = "overlay2";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    virtualisation.docker.storageDriver = cfg.storageDriver;
  };
}
