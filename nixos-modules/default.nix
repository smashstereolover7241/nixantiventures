{ ... }:

{
  imports = [
    ./main.nix
    ./pin-nixpkgs.nix
    ./lang.nix
    ./util.nix
    ./ssh.nix
    ./wireguard.nix
    ./theGrandUtilities.nix
    ./pipewire.nix
    ./filemanagers.nix
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
