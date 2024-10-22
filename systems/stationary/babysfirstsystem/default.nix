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
