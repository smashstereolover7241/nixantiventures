{ nixpkgs, home-manager, ... }:
{
    nixosConfigurations.babysfirstsystem = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =

        [

          home-manager.nixosModules.home-manager
          {
          imports = [ ./within.nix
#                      ./homeBasics.nix
                      ../../../common/shim.nix
                    ];
          vim.enable = true;
#          hm.enable = true;
          shim.test.enable = true;
            home-manager.useUserPackages = true;
          }
          ({ pkgs, config, lib, home-manager, ... }: {
          boot.isContainer = true;


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
