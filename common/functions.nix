{ nixpkgs, home-manager, self, lib, dirScan, ... }@inputs:

let
  inherit
    (nixpkgs)
    home-manager
    self
    lib
    ;
    currentDir = dirScan;
    currentDirContents = builtins.readDir currentDir;
    flipped = inputs.nixpkgs.lib.mapAttrs' (name: value: inputs.nixpkgs.lib.nameValuePair (value+name) (name)) currentDirContents;
    filtered = inputs.nixpkgs.lib.filterAttrs (n: v: (builtins.match "^directory.+" n) == [] ) flipped;
    theList = inputs.nixpkgs.lib.attrsets.attrValues filtered;
    list = inputs.nixpkgs.lib.lists.forEach theList (x: ./. + ( "/" + x));
in
{
  dirput = list;
}
