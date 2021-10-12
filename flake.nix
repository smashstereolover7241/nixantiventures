{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-21.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs?ref=master";
    rust-overlay.url = "github:oxalica/rust-overlay";
    easystroke = {
      url = "github:teu5us/easystroke-nix";
      flake = false;
      };
    python-validity = {
      url = "/home/localhost/git/workspace/python-validity";
      flake = false;
      };
  };

  # PACKAGES

  outputs = {
      self
      , nixpkgs
      , nixpkgs-unstable
      , ...
    }@inputs:
      let
        inherit (nixpkgs-unstable.lib) nixosSystem;
        supportedSystems = [ "x86_64-linux"];
        forAllSystems' = systems: f: nixpkgs.lib.genAttrs systems (system: f system);
        forAllSystems = forAllSystems' supportedSystems;
      in {

        nixosConfigurations.ProGo = nixosSystem (import ./systems/ProGo.nix inputs);
        ProGo = self.nixosConfigurations.ProGo.config.system.build.toplevel;

        nixosConfigurations.ProNoGo = nixosSystem (import ./systems/ProNoGo.nix inputs);
        ProNoGo = self.nixosConfigurations.ProGo.config.system.build.toplevel;

        nixosConfigurations.ProProGo = nixosSystem (import ./systems/ProProGo.nix inputs);
        ProProGo = self.nixosConfigurations.ProGo.config.system.build.toplevel;

        nixosConfigurations.ProPenGo = nixosSystem (import ./systems/ProPenGo.nix inputs);
        ProPenGo = self.nixosConfigurations.ProPenGo.config.system.build.toplevel;

        nixosConfigurations.ProNoBrain = nixosSystem (import ./systems/ProNoBrain.nix inputs);
        ProNoBrain = self.nixosConfigurations.ProGo.config.system.build.toplevel;

        nixosConfigurations.ProSlowGo = nixosSystem (import ./systems/ProSlowGo.nix inputs);
        ProSlowGo = self.nixosConfigurations.ProGo.config.system.build.toplevel;

        nixosConfigurations.ProVerySlowGo = nixosSystem (import ./systems/ProVerySlowGo.nix inputs);
        ProVerySlowGo = self.nixosConfigurations.ProGo.config.system.build.toplevel;

        allSystems =
          let
            pkgs = system: import nixpkgs { system = "x86_64-linux"; };
            linkFarm = system: attrs:
              let
                pkgs' = pkgs system;
              in
                pkgs'.linkFarm "allSystems-${system}"
                (pkgs'.lib.mapAttrsToList (n: v: { name = n; path = v; }) attrs);
                nixos = name: self.nixosConfigurations.${name}.config.system.build.toplevel;
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
                };
            };
        overlays = {
          rust-overlay = inputs.rust-overlay.overlay;
          easystroke = final: prev:
            {
              easystroke = import "${inputs.easystroke}/default.nix" { pkgs = final; };
            };

          python-validity = final: prev:
            {
              python-validity = import "${inputs.python-validity}/default.nix" { pkgs = final; };
            };
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
#                 easystroke = mkPkg "easystroke";
      #                        easy-hls-nix = if system == "x86_64-linux" then mkPkg "easy-hls-nix" else (import nixpkgs-unstable { inherit system; }).hello;
              });
      };
}
