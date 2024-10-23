{ lib, ... }:
with lib;
let cfg = config.real.home-manager;
in
{
  imports = [
    ./users.nix
    ./defaults.nix
  ];
}
