{ config, lib, pkgs, ... }:
with lib;
let
  cfg = modules.normal.system.flakes;
in {
  options.modules.normal.system.flakes = {
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
