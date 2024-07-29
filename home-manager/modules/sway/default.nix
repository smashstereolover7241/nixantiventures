{ pkgs, config, lib, inputs, ... }:
with lib;
let 
   cfg = config.teletypeOne.sway;
in
{
imports = [
      ./swayidle.nix
      ./swaylock.nix
   ];
}
