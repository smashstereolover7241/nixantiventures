{ options, config, lib, inputs, ... }:
with lib;
{
  imports = [
    ./waybar
    ./hyprland
    ./cli
    ./test.nix
  ];
}
