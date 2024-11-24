{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.real.normal.display.fixes;
in
{
  options.real.normal.display.fixes = {
    backlightFix = mkEnableOption "fix backlight, maybe";
    wacomFix = mkEnableOption "Fix wacom (X200T)";
  };

  config = (mkMerge [
    (mkIf cfg.backlightFix {
      services.xserver.extraConfig = ''
        Section "Device"
        Identifier  "Intel Graphics"
        Driver      "intel"
        Option      "Backlight"  "intel_backlight"
        EndSection
      '';
      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
      '';
    })

    (mkIf cfg.wacomFix {
      #couldn't get it working with a single service, so 2 it is
      systemd.services.inputattach = {
        wantedBy = [ "multi-user.target" ];
        description = "inputattach thingy";
        serviceConfig = {
          Type = "simple";
          ExecStart="/run/current-system/sw/bin/isdv4-serial-inputattach /dev/ttyS0";
        };
      };
      #Need to reattach the device after every suspend, otherwise no worky
      systemd.services.inputreattach = {
        wantedBy = [ "suspend.target" ];
        after = [ "suspend.target" ];
        description = "inputattach thingy";
        serviceConfig = {
          Type = "simple";
          ExecStartPre="/run/current-system/sw/bin/sleep 5"; # takes a moment to show up
          ExecStart="/run/current-system/sw/bin/isdv4-serial-inputattach /dev/ttyS0";
        };
      };
    })

  ]);
}
