{ config, lib, pkgs, ... }:

{
    imports = [ ../../../common/shim.nix ];
    shim.enable = true;
    shim.hmusers = true;
}
