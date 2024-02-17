{ options, config, lib, inputs, ... }:
with lib;
{
  imports = [
    ./waybar
    ./test.nix
  ];
}
