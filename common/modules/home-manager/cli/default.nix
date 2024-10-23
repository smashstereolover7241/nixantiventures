{ pkgs, config, lib, inputs, ... }:
with lib;
let cfg = config.real.home-manager.cli;
in
{
  imports = [
    ./zsh
  ];
}
