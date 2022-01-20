{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.lang;
in {
  options.teletypeOne.lang = {
    rust = mkEnableOption "Install rust language compiler and utilities";
    python = mkEnableOption "Install python 39 full";
    pythonML = mkEnableOption "Install pythonML stuffs";
  };
  config = (mkMerge [
    (mkIf cfg.rust {
      environment.systemPackages = with pkgs; [pkgs.rust-bin.stable.latest.default rustup rustc gcc clang];
    })
    (mkIf cfg.python {
      environment.systemPackages = with pkgs; [python39Full python39Packages.pip];
    })
    (mkIf cfg.pythonML {
#environment.systemPackages = with pkgs; [python39Packages.tensorflow_2];
    })
  ]);
}
