{ options, config, lib, inputs, ... }:
with lib;
{
  imports = [
    ./waybar
    ./cli
    ./test.nix
  ];
}
