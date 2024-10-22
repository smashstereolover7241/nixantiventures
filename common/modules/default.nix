{ lib, ... }:
with lib;
let cfg = config.real;
in
{
  imports = [
    ./normal
  ];
}
