{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.teletypeOne.flakes;
in {
  options.teletypeOne.flakes = {
    enable = mkEnableOption "Flakes need flake support";
  };
  config = {
    nix = let
      nix = pkgs.nixVersions.stable;
    in {
      package = nix;
      extraOptions = ''
        experimental-features = nix-command flakes 
        '';
    };
  };
}
