{
  description = "A very shitty flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ...}@inputs:
    let
      systems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
#        lib = import ./systems/stationary/default.nix {
#        lib.attrsets.genAttrs = (import ./systems/stationary/default.nix {inherit nixpkgs;});
#        defaultPackage = forAllSystems (system: systems);
#        inherit (partner);
      nixosConfigurations = (import ./systems inputs).nixosConfigurations;

#        inherit (import ./systems/stationary/default.nix {inherit nixpkgs;});
#
#        defaultSystems = import ./systems/stationary/default.nix {inherit nixpkgs;};
#   };
        # builtins.debug.trace systems systems;
          };
    #  systems = import ./systems/stationary/default.nix;
#  import ./test.nix;
   #outputs = { self, nixpkgs, ... }@inputs:
   #     test = import ./systems/stationary/babysfirstsystem {inherit nixpkgs ;};
    #import = [
#      ./systems/stationary/default.nix
#      systems = import ./systems/stationary/default.nix;
    # let
    #  in {
    #  systems = import systems/stationary/default.nix;
    #   systems-outputs = systems.outputs;
    #    inherit self;
    #    inherit nixpkgs;
    #  };

#      test = zippy-outputs.packages.${system}.default;
#  };
}
