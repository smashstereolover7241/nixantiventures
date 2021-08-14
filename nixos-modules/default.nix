{ ... }:

{
  imports = [
    ./main.nix
    ./util.nix
    ./games.nix
    ./zsh.nix
    ./communication.nix
    ./fonts.nix
    ./terminals.nix
    ./xorg
    ./flakes.nix
    ./pulseaudio.nix
    ./networking.nix
    ../hardware/default.nix
  ];
}
