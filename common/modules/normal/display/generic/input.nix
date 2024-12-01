{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.normal.display.generic.input;
in
{
  options.modules.normal.display.generic.input = {
    libinput = mkEnableOption "Enable libinput";
    flatInput = mkEnableOption "Add extra config for non-accelerated mouse input.";
    wacom = mkEnableOption "Install & enable wacom drivers";
  };

  config = (mkMerge [
      { services.libinput.enable = cfg.libinput; }
      { services.xserver.wacom.enable = cfg.wacom; }

      (mkIf cfg.flatInput {
        #TODO: Wayland (hyprland; maybe set in shim)
        services.xserver.extraConfig = ''
          Section "InputClass"
          Identifier "My Mouse"
          MatchIsPointer "yes"
          Option "AccelerationProfile" "-1"
          Option "AccelerationScheme" "none"
          Option "AccelSpeed" "-1"
          EndSection
      '';
    })
  ]);
}
