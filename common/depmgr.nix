{ lib, config, pkgs, home-manager, ... }@inputs:

with lib;

let
    cfg = config.depmgr;
    cfg2 = config.modules;
    # make things easy to change, less repeat
    cfhm = config.depmgr.home-manager;
    hmsystem = config.depmgr.home-manager.system;
    cfnm = config.depmgr.normal;
    nmsystem = cfnm.system;
    nmdisplay = cfnm.display;
    nmmon = cfnm.monitoring;
in {
    imports = [./modules];
    options.modules.normal.media.audio.music.all = mkEnableOption "Enable all the music";
    options.modules.normal.media.image.viewers.all = mkEnableOption "Enable all the image viewing";
    options.modules.normal.media.image.creation.all = mkEnableOption "Enable all the image creation";
    options.modules.normal.media.video.viewers.all = mkEnableOption "Enable all the video viewing";
#    options.modules.normal.media.video.creation.all = mkEnableOption "Enable all the video creation";
    options.modules.normal.media.screenshot.all = mkEnableOption "Enable all the screenshots";
    options.modules.normal.system.monitoring.cli.tops.all = mkEnableOption "Enable all the screenshots";
    options.modules.normal.system.monitoring.cli.all = mkEnableOption "Enable all the screenshots";
    options.modules.normal.system.monitoring.gui.all = mkEnableOption "Enable all the screenshots";
    options.modules.normal.system.monitoring.all = mkEnableOption "Enable all the screenshots";
    config = (
        (mkMerge [

        ####HOME MANAGED MODULES
#        (mkIf cfhm.defaults {
#             modules.home-manager.defaults = true;
#        })

            (mkIf cfg2.home-manager.users.enable (mkMerge [
            {
                modules.normal.system.users.enable = true;
                modules.normal.system.users.name = cfg2.home-manager.users.name;
            }

            (mkIf cfg2.home-manager.cli.shell.zsh.enable {
                modules.home-manager.cli.shell.zsh.username = mkDefault cfg2.home-manager.users.name;
            })]
            ))

#        (mkIf nmdisplay.drivers.enable (mkMerge [
#            (mkIf nmdisplay.drivers.rocm {
#                modules.normal.display.drivers.firmware = true;
#                modules.normal.display.drivers.rocm = true;
#            })
#            {
#                modules.normal.display.drivers.firmware = mkDefault nmdisplay.drivers.firmware;
#                TODO: remove option from drivers, place it here and make secondary option
#
            (mkIf cfg2.normal.display.login-managers.lightdm.enable {
                modules.normal.display.servers.xorg.enable = true;
            })

            (mkIf cfg2.normal.display.window-managers.xmonad.enable {
                modules.normal.display.servers.xorg.enable = true;
            })

            (mkIf cfg2.normal.gaming.launchers.steam.enable {
                modules.normal.display.servers.xorg.enable = true; #TODO: Split out graphics (32) to generic servers option, disable requriement of x.org for steam
            })

            (mkIf cfg2.normal.media.audio.music.ncmpcpp.enable {
                modules.normal.media.audio.music.mpd.enable = true;
            })

            (mkIf cfg2.normal.media.audio.music.mpc-cli.enable {
                modules.normal.media.audio.music.mpd.enable = true;
            })

            (mkIf cfg2.normal.media.audio.music.all {
                modules.normal.media.audio.music.mpd.enable = true;
                modules.normal.media.audio.music.ncmpcpp.enable = true;
                modules.normal.media.audio.music.mpc-cli.enable = true;
            })

            (mkIf cfg2.normal.media.image.viewers.all {
                modules.normal.media.image.viewers.feh.enable = true;
            })

            (mkIf cfg2.normal.media.image.creation.all {
                modules.normal.media.image.creation.kolourpaint.enable = true;
                modules.normal.media.image.creation.krita.enable = true;
                modules.normal.media.image.creation.gimp.enable = true;
            })

            (mkIf cfg2.normal.media.screenshot.all {
                modules.normal.media.screenshot.gnome-screenshot.enable = true;
                modules.normal.media.screenshot.scrot.enable = true;
                modules.normal.media.screenshot.peek.enable = true;
            })

            (mkIf cfg2.normal.system.monitoring.all {
                modules.normal.system.monitoring.cli.all = true;
                modules.normal.system.monitoring.gui.all = true;
            })
            (mkIf cfg2.normal.system.monitoring.gui.all {
                modules.normal.system.monitoring.gui.mission-center.enable = true;
            })

            (mkIf cfg2.normal.system.monitoring.cli.all {
                modules.normal.system.monitoring.cli.tops.all = true;
                modules.normal.system.monitoring.cli.nvtop.enable = true;
                modules.normal.system.monitoring.cli.glances.enable = true;
            })

            (mkIf cfg2.normal.system.monitoring.cli.tops.all {
                modules.normal.system.monitoring.cli.tops.btop.enable = true;
                modules.normal.system.monitoring.cli.tops.htop.enable = true;
                modules.normal.system.monitoring.cli.tops.iotop.enable = true;
            })
        ]));
}
