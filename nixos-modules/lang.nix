{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.lang;
in {

  options.teletypeOne.lang = {
    python = mkEnableOption "Install python 39 full";
    java11 = mkEnableOption "Install java11";
  };

  config = (mkMerge [
    (mkIf cfg.python {
      environment.systemPackages = with pkgs; [python39Full python39Packages.pip];
    })

    (mkIf cfg.java11 {
      environment.systemPackages = with pkgs; [openjdk11];
    })   
  ]);
}
