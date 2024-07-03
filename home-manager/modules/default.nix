{ options, config, lib, inputs, ... }:
with lib;
{
  imports = [
    ./waybar
    ./cli
    ./sway
    ./test.nix
  ];
}
