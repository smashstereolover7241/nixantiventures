{ config, lib, pkgs, ... }:

{
    imports = [ ../../../common/shim.nix ];
    shim = {
        enable = true;
        home-manager = {
            users = true;
        };
        normal = {
          system = {
#            users = false; #Use default.
#            flakes = true; #Use default.
          };
        };
    };
}
