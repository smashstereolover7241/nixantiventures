{ ... }:

{
  imports = [
    ./main.nix
    ./pin-nixpkgs.nix
    ./lang.nix
    ./util.nix
    ./server.nix
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
    ./android.nix
    ./emulation.nix
    ./monitoring.nix
    ./internet.nix
    ../hardware/default.nix
  ];
}
