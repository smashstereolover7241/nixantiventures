{ nixpkgs, dirToScan, ... }@inputs:

let
    currentDirContents = builtins.readDir dirToScan;
    flipped = inputs.nixpkgs.lib.mapAttrs' (name: value: inputs.nixpkgs.lib.nameValuePair (value+name) (name)) currentDirContents;
    filtered = inputs.nixpkgs.lib.filterAttrs (n: v: (builtins.match "^directory.+" n) == [] ) flipped;
    theList = inputs.nixpkgs.lib.attrsets.attrValues filtered;
in
{
  list = inputs.nixpkgs.lib.lists.forEach theList (x: dirToScan + ( "/" + x));
}
