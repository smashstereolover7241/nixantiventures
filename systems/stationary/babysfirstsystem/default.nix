{ nixpkgs, ... }:
{
    nixosConfigurations.babysfirstsystem = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [ ({ pkgs, config, lib, ... }: {
          boot.isContainer = true;
#            home-manager.useGlobalPkgs = true;
#            home-manager.useUserPackages = true;
            # Let 'nixos-version --json' know about the Git revision
            # of this flake.
#            system.configurationRevision = "";

            # Network configuration.
            networking.useDHCP = false;
            networking.firewall.allowedTCPPorts = [ 80 ];

            # Enable a web server.
            services.httpd = {
              enable = true;
              adminAddr = "morty@example.org";
            };
          })

        ];
    };
}