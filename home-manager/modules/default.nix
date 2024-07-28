{ options, config, lib, inputs, ... }:
with lib;
{
  imports = [
    ./waybar
    ./cli
    ./sway
    ./editors
    ./editors
    ./test.nix
  ];
}
