{ lib, config, pkgs, ... }:

with lib;

let cfg = config.vim;
in {
  options.vim.enable = mkEnableOption "Enables Within's vim config";

  config = mkIf cfg.enable {

  };
}
