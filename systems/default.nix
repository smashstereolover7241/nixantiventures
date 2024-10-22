{ nixpkgs, home-manager, ... }@inputs:
let
  inherit
    (nixpkgs)
    home-manager
    lib
    ;

  list = [
    ./mobile
    ./stationary
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
