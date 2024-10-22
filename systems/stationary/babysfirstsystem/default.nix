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
            networking = {
            hostName = systemName;
            useDHCP = false;
            hostId = "5457b35a";
            };
            #TODO: make this it's own module with pass-through args, so defaults can be changed easily

            nixpkgs.config.allowUnfree = true;

            time.timeZone = "Europe/Berlin";
            system.stateVersion = "21.05";
            hardware.enableRedistributableFirmware = true;
            # Network configuration.
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
