{ nixpkgs, home-manager, self, ... }@inputs:
let
  inherit
    (nixpkgs)
    home-manager
    self
    lib
    ;
    currentDir = builtins.toString ./.;
    currentDirContents = builtins.readDir currentDir;
    flipped = inputs.nixpkgs.lib.mapAttrs' (name: value: inputs.nixpkgs.lib.nameValuePair (value+name) (name)) currentDirContents;
    filtered = inputs.nixpkgs.lib.filterAttrs (n: v: (builtins.match "^directory.+" n) == [] ) flipped;
    theList = inputs.nixpkgs.lib.attrsets.attrValues filtered;
    list = inputs.nixpkgs.lib.lists.forEach theList (x: ./. + ( "/" + x));


#  list = [
#   ./babysfirstsystem
#    ./container
#  ];
in
{
  nixosConfigurations = lib.pipe list [
    (map import)
    (map (a: a inputs))
    (map (a: a.nixosConfigurations or {}))
    (lib.foldl' (acc: x: acc // x) {})
  ];
}

