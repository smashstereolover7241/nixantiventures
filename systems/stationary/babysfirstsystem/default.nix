{ nixpkgs, home-manager, self, ... }:
{
    nixosConfigurations.babysfirstsystem = nixpkgs.lib.nixosSystem {
     # path = self.path;
      system = "x86_64-linux";
      modules =

        [

          home-manager.nixosModules.home-manager
          {
          imports = [
#                      ./homeBasics.nix
                      ../../../common/shim.nix
                      ./hardware.nix
                      # somehow make this dynamic using path, as we do not know how many subdirs this is in
                    ];
          shim.enable = true;
          shim.users = false;
          shim.hmusers = true;
#          shim.homeTest = true;
            home-manager.useUserPackages = true;
          }
          ({ pkgs, config, lib, home-manager, ... }: {

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
