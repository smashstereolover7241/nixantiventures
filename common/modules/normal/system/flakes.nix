{ config, lib, pkgs, ... }:
with lib;
let
  cfg = real.normal.system.flakes;
in {
  options.real.normal.system.flakes = {
    enable = mkEnableOption "Since flakes will be stable in about never, one needs to enable them.";
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
