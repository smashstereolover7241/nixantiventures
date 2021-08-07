{ ... }:

{
  imports = [
    ./main.nix
    ./flakes.nix
    ./pulseaudio.nix
    ./networking.nix
    ../hardware/default.nix
  ];
}
