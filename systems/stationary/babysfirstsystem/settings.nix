{ config, lib, pkgs, ... }:

{
    imports = [ ../../../common/shim.nix ];
    shim = {
        enable = true;
        home-manager = {
            users = true;
        };
        normal = {
          users = true;
        };
    };
}
