{ lib, dirToScan, ... }@inputs:

let
  currentDir = builtins.toString ./.;
  dirContents = builtins.readDir currentDir;
  nixFiles = lib.filterAttrs (n: v: (((builtins.match "^.+nix" n) == []) && ((builtins.match "^default.+nix" n) != [])) || v == "directory" ) dirContents;
in
{
  yallah = lib.forEach (lib.attrNames nixFiles) (x: ./. + ( "/" +x ));
}
