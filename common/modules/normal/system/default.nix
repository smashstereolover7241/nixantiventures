{ lib, ... }:
with lib;
let cfg = config.real.normal.system;
in
{
  imports = [
    ./users.nix
    ./flakes.nix
  ];
}
