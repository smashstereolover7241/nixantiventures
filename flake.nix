{
  inputs = {
  # nixpkgs.url = "github:NixOS/nixpkgs?ref=23.11";
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs?ref=master";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows =
        "nixpkgs-unstable"; 
    };
  };

  # PACKAGES

  outputs = {
      self
      , nixpkgs
      , nixpkgs-unstable
      , home-manager
      , ...
    }@inputs:
      let
        inherit (nixpkgs-unstable.lib) nixosSystem;
	inherit (home-manager.lib) homeManagerConfiguration;
        supportedSystems = [ "x86_64-linux"];
        forAllSystems' = systems: f: nixpkgs.lib.genAttrs systems (system: f system);
        forAllSystems = forAllSystems' supportedSystems;
      in {

        nixosConfigurations.ProGo = nixosSystem (import ./systems/ProGo.nix inputs);
        ProGo = self.nixosConfigurations.ProGo.config.system.build.toplevel;

        nixosConfigurations.ProSlimShady = nixosSystem (import ./systems/ProSlimShady.nix inputs);
        ProSlimShady = self.nixosConfigurations.ProSlimShady.config.system.build.toplevel;

        nixosConfigurations.ProNoGo = nixosSystem (import ./systems/ProNoGo.nix inputs);
        ProNoGo = self.nixosConfigurations.ProNoGo.config.system.build.toplevel;

        nixosConfigurations.ProProGo = nixosSystem (import ./systems/ProProGo.nix inputs);
        ProProGo = self.nixosConfigurations.ProProGo.config.system.build.toplevel;

        nixosConfigurations.VictoryLaptop= nixosSystem (import ./systems/VictoryLaptop.nix inputs);
        VictoryLaptop = self.nixosConfigurations.VictoryLaptop.config.system.build.toplevel;

        nixosConfigurations.ProPenGo = nixosSystem (import ./systems/ProPenGo.nix inputs);
        ProPenGo = self.nixosConfigurations.ProPenGo.config.system.build.toplevel;

        nixosConfigurations.ProNoBrain = nixosSystem (import ./systems/ProNoBrain.nix inputs);
        ProNoBrain = self.nixosConfigurations.ProNoBrain.config.system.build.toplevel;

        nixosConfigurations.ProSlowGo = nixosSystem (import ./systems/ProSlowGo.nix inputs);
        ProSlowGo = self.nixosConfigurations.ProSlowGo.config.system.build.toplevel;

        nixosConfigurations.ProVerySlowGo = nixosSystem (import ./systems/ProVerySlowGo.nix inputs);
        ProVerySlowGo = self.nixosConfigurations.ProVerySlowGo.config.system.build.toplevel;

        nixosConfigurations.Samantha = nixosSystem (import ./systems/Samantha.nix inputs);
        Samantha = self.nixosConfigurations.Samantha.config.system.build.toplevel;

        nixosConfigurations.remote = nixosSystem (import ./systems/remote.nix inputs);
        remote = self.nixosConfigurations.remote.config.system.build.toplevel;

        nixosConfigurations.sample = nixosSystem (import ./systems/sample.nix inputs);
        sample = self.nixosConfigurations.sample.config.system.build.toplevel;
	# to have sample tested as output

        allSystems =
          let
            pkgs = system: import nixpkgs { system = "x86_64-linux"; };
#            drucker = import inputs.druckerrepo { system = "x86_64-linux"; };

            linkFarm = system: attrs:
              let
                pkgs' = pkgs system;
              in
                pkgs'.linkFarm "allSystems-${system}"
                (pkgs'.lib.mapAttrsToList (n: v: { name = n; path = v; }) attrs);
                nixos = name: self.nixosConfigurations.${name}.config.system.build.toplevel;
		hm = name: self.homeConfigurations.${name}.activationPackage;
          in
            {
              x86_64-linux = linkFarm "x86_64-linux"
                {
                   ProGo = nixos "ProGo";
                   ProProGo = nixos "ProProGo";
                   ProNoGo = nixos "ProNoGo";
                   ProNoBrain = nixos "ProNoBrain";
                   ProSlowGo = nixos "ProSlowGo";
                   ProVerySlowGo = nixos "ProVerySlowGo";
                   ProSlimShady = nixos "ProSlimShady";
                   VictoryLaptop = nixos "VictoryLaptop";
                   Samantha = nixos "Samantha";
                   sample = nixos "sample";
                   remote = nixos "remote";
                };
            };
        overlays = {
           #
         };
        packages =
          forAllSystems (system:
            let
              mkPkg'' =
                pkgs: name: package:
                (import pkgs { inherit system;
                               overlays = nixpkgs.lib.mapAttrsToList
                                 (_: v: v) self.overlays;
                             }).teletypeOne."${package}";
              mkPkg' = mkPkg'' nixpkgs-unstable;
              mkPkg = name: mkPkg'' nixpkgs-unstable name name;
            in
              {
	        #
              });
      };
}
