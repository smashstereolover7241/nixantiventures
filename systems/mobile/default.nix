{ nixpkgs, ... }@inputs:
let
  inherit
    (nixpkgs)
    lib
    ;

  list = [
  ];
in
{
  nixosConfigurations = lib.pipe list [
    (map import)
    (map (a: a inputs))
    (map (a: a.nixosConfigurations or {}))
    (lib.foldl' (acc: x: acc // x) {})
  ];
}

