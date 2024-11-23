{ lib, self, ... }:
let
  inherit
    self
    lib
    ;
    currentDir = builtins.toString ./.;
    rootPath = (lib.filesystem.locateDominatingFile "flake.nix" ./.).path;
    importList = ((import (rootPath + "/common/functions/importDir.nix")) { inherit lib; dirToScan = currentDir; }).importList;
in
{
  imports = importList;
}
