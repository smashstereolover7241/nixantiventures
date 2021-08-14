{ ... }:

{
  imports = [
    ./main.nix
    ./util.nix
    ./fonts.nix
    ./terminals.nix
    ./xorg
    ./flakes.nix
    ./pulseaudio.nix
    ./networking.nix
    ../hardware/default.nix
  ];
}
