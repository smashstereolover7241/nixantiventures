{ lib, dirToScan, ... }@inputs:

let
  dirContents = builtins.readDir dirToScan;
  nixFiles = lib.filterAttrs (n: v: (((builtins.match "^.+nix" n) == []) && ((builtins.match "^default\.nix$" n) != [])) || v == "directory" ) dirContents;
in
{
   importList = lib.forEach (lib.attrNames nixFiles) (x: dirToScan + ( "/" +x ));
}
