{ lib, dirToScan, ... }@inputs:

let
  dirContents = builtins.readDir dirToScan;
  nixFiles = lib.filterAttrs (n: v: (((builtins.match "^.+nix" n) == []) && ((builtins.match "^default\.nix$" n) != [])) || v == "directory" ) dirContents;
in
{
  #TODO: Check if folders have default.nix; otherwise ignore and warn!
   importList = lib.forEach (lib.attrNames nixFiles) (x: dirToScan + ( "/" +x ));
}
