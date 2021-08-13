inputs: {
  system = "x86_64-linux";

  modules = [
    ../nixos-modules/default.nix
    ({ pkgs, config, lib, ... }:
      let
        inherit (config.teletypeOne.pkgs) nixpkgs-unstable;
      in
        {
          teletypeOne = {
            xorg = {
              enable = true;
              gpu = "nvidia";
              xmonad = true;
              lightdm = true;
              libinput = true;
            };

            networking  = {
              bluetooth = true;
              networkManager = true;
            };


            hardware.ProGo = true;
            flakes.enable = true;

          };
        }
    )
  ] ++ [
    ({ pkgs, ... }: {
      networking = {
        hostName = "ProGo";
        useDHCP = false;
        hostId = "3457b394";
      };

      time.timeZone = "Europe/Berlin";
      system.stateVersion = "21.05";
    })
  ];
}
