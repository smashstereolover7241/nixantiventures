{ config, lib, pkgs, ... }:
let
    rootPath = (lib.filesystem.locateDominatingFile "flake.nix" ./.).path; # this is severly stupid, couldn't find a better way tho;
in
{
  imports = [ (rootPath + "/common/shim.nix") ];
    shim = {
        enable = true;
        home-manager = {
            users = true;
        };
        normal = {
          system = {
#            users = false; #Use default.
#            flakes = true; #Use default.
          };
        };
    };
}
