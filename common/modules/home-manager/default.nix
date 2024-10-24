#TODO: make this shit automatic... (scan for dirs AND files)
{ pkgs, config, lib, inputs, ... }:
with lib;
let cfg = config.real.home-manager;
in
{
  imports = [
    ./system
    ./cli
    ./editors
  ];
}
