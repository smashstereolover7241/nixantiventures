{ options, config, lib, inputs, ... }:
with lib;
{
  imports = [
    ./waybar
    ./hyprland
    ./test.nix
  ];
}
