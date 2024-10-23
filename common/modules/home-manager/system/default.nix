{ lib, ... }:
with lib;
let cfg = config.real.home-manager.system;
in
{
  imports = [
    ./users.nix
    ./defaults.nix
  ];
}
