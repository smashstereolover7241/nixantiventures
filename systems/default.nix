{ nixpkgs, self, ... }@inputs:
let
  inherit
    (nixpkgs)
    home-manager
    self
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
