{ nixpkgs, home-manager, self, ... }:
{
    nixosConfigurations.babysfirstsystem = nixpkgs.lib.nixosSystem {
     # path = self.path;
      system = "x86_64-linux";
      modules =

        [

          home-manager.nixosModules.home-manager
          {
          imports = [ ./within.nix
#                      ./homeBasics.nix
                      ../../../common/shim.nix
                      # somehow make this dynamic using path, as we do not know how many subdirs this is in
                    ];
          vim.enable = true;
#          hm.enable = true;
          shim.enable = true;
#          shim.homeTest = true;
            home-manager.useUserPackages = true;
          }
          ({ pkgs, config, lib, home-manager, ... }: {
#          boot.isContainer = true;

  users = {
    users.amy = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [ "kvm" "networkmanager" "wheel" "audio" "video" "network" "input" ];
   #                 ++ (optional nm-enable "network-manager");
    };
    groups.amy = {
      gid = 1002;
    };
  };


################ TEMPORARY TEST HARDWARE CONFIG
################ NONFUNCTIONAL
################
################

boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

fileSystems."/" =
    { device = "/dev/disk/by-uuid/noU";
      fsType = "ext4";
    };

      boot.loader.grub.enable = true;
      boot.loader.grub.device = "nodev";
      nixpkgs.config.allowUnfree = true;

  swapDevices = [ ];

################
################
################
################
################



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
