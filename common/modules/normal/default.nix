{ lib, ... }:
with lib;
let cfg = config.real.normal;
in
{
  imports = [
    ./system
  ];
}
