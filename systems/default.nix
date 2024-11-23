#TODO: Scan recursively, without requiring default.nix in each folder.
{ nixpkgs, self, ... }@inputs:
let
  inherit
    (nixpkgs)
    self
    lib
    ;
    currentDir = builtins.toString ./.;
    rootPath = toString inputs.self; #need this as string, otherwise weird things happen
    list = ((import (rootPath + "/common/functions/scanDir.nix")) { inherit nixpkgs; dirToScan = currentDir; }).list;
in
{
  nixosConfigurations = lib.pipe list [
    (map import)
    (map (a: a inputs))
    (map (a: a.nixosConfigurations or {}))
    (lib.foldl' (acc: x: acc // x) {})
  ];
}
