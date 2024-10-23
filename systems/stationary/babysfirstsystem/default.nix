{ nixpkgs, home-manager, self, ... }:
let
  systemName = builtins.toString  (builtins.match ".*[/](.*)$" (builtins.toString ./.));
in
{
    nixosConfigurations.${systemName}  = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          home-manager.nixosModules.home-manager
          {
          imports = [
                      ./hardware.nix
                      ./settings.nix
          ];
          }
          ({ pkgs, config, lib, ... }@inputs: {
              home-manager.extraSpecialArgs = { inherit inputs;};
              imports = [
                (import (toString self + "/systems/common.nix") {inherit pkgs config lib; systemName = systemName;})
              ];
          })
        ];
    };
}
