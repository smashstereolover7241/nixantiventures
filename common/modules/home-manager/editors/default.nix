{ pkgs, config, lib, inputs, ... }:
with lib;
let cfg = config.real.home-manager.editors;
in
{
  imports = [
#    ./emacs
  ];
}
