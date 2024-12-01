{ lib, config, pkgs, ... }@inputs:

with lib;

let cfg = config.modules.home-manager.defaults;
in {
    options.modules.home-manager.defaults = mkEnableOption "Enables basic defaults.";
    config = mkIf cfg {
        home-manager.extraSpecialArgs = { inherit inputs;};
        home-manager.useGlobalPkgs = true;
    };
}
