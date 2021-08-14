{ ... }:

{
  imports = [
    ./main.nix
    ./fonts.nix
    ./terminals.nix
    ./xorg
    ./flakes.nix
    ./pulseaudio.nix
    ./networking.nix
    ../hardware/default.nix
  ];
}
