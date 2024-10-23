{ lib, config, pkgs, ... }@inputs:

with lib;

let cfg = config.real.home-manager.defaults;
in {
    options.real.home-manager.defaults = mkEnableOption "Enables basic defaults.";
    config = mkIf cfg {
        home-manager.extraSpecialArgs = { inherit inputs;};
        home-manager.useGlobalPkgs = true;
    };
}
