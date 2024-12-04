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
    options.modules.normal.display.window-managers.xmonadGoodies  = mkEnableOption "Some stuff probably wanted with xmonad";
    options.modules.normal.display.window-managers.swayGoodies = mkEnableOption "Some stuff probably wanted with swavyland";
    options.modules.normal.media.audio.music.all = mkEnableOption "Enable all the music";
    options.modules.normal.media.image.viewers.all = mkEnableOption "Enable all the image viewing";
    options.modules.normal.media.image.creation.all = mkEnableOption "Enable all the image creation";
    options.modules.normal.media.video.viewers.all = mkEnableOption "Enable all the video viewing";
#    options.modules.normal.media.video.creation.all = mkEnableOption "Enable all the video creation";
    options.modules.normal.media.screenshot.all = mkEnableOption "Enable all the screenshots";
    options.modules.normal.media.productivity.programming.all = mkEnableOption "All things programming";
    options.modules.normal.media.productivity.text-editors.gui.emacsGoodies = mkEnableOption "Goodies for emacs";
    options.modules.normal.system.monitoring.cli.tops.all = mkEnableOption "Enable all the tops";
    options.modules.normal.system.monitoring.cli.all = mkEnableOption "Enable all the cli monitoring";
    options.modules.normal.system.monitoring.gui.all = mkEnableOption "Enable all the gui monitoring";
    options.modules.normal.system.monitoring.all = mkEnableOption "Enable all the monitoring";
    options.modules.normal.cli.fetches.all = mkEnableOption "Enable all the fetches";
    options.modules.normal.cli.util.all = mkEnableOption "Enable all the cli utils";
    options.modules.normal.system.compute.all = mkEnableOption "All things compute";
    options.modules.normal.system.compute.lang.all = mkEnableOption "All things lang";
    options.modules.normal.system.compute.lang.c.all = mkEnableOption "All things clang";
    options.modules.normal.system.compute.lang.haskell.all = mkEnableOption "All things haskell";
    options.modules.normal.system.compute.lang.util.all = mkEnableOption "All things languitilil";
    options.modules.normal.system.compute.database.all = mkEnableOption "All things database";
    options.modules.normal.system.compute.compression.all = mkEnableOption "All compression";
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
                modules.normal.system.compute.lang.haskell.all = true;
            })

            (mkIf cfg2.normal.display.window-managers.xmonadGoodies {
                modules.normal.display.servers.xorg.util.xkill.enable = true;
                modules.normal.display.servers.xorg.util.arandr.enable = true;
                modules.normal.display.window-managers.util.trays.stalonetray.enable = true; #todo: xmobar?
                modules.normal.display.window-managers.util.wmctrl.enable = true;
                modules.normal.display.window-managers.util.notifications.dunst.enable = true;
                modules.normal.display.window-managers.util.launchers.rofi.enable = true;
                modules.normal.display.window-managers.util.launchers.gmrun.enable = true;
                modules.normal.display.window-managers.util.brightness.acpilight.enable = true;
                modules.normal.media.audio.control.playerctl.enable = true;
                modules.normal.media.audio.util.alsa-utils.enable = true;
            })
            (mkIf cfg2.normal.display.window-managers.swayGoodies {
                modules.normal.display.servers.wayland.util.wdisplays.enable = true;
                modules.normal.display.window-managers.util.wmctrl.enable = true; #todo: waybar?
                modules.normal.display.window-managers.util.launchers.wofi.enable = true;
                modules.normal.display.window-managers.util.launchers.gmrun.enable = true;
                modules.normal.display.window-managers.util.launchers.nwg-drawer.enable = true;
                modules.normal.display.window-managers.util.notifications.dunst.enable = true;
                modules.normal.display.window-managers.util.brightness.acpilight.enable = true;
                modules.normal.media.audio.control.playerctl.enable = true;
                modules.normal.media.audio.util.alsa-utils.enable = true;
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

            (mkIf cfg2.normal.cli.fetches.all {
                modules.normal.cli.fetches.neofetch.enable = true;
                modules.normal.cli.fetches.hyfetch.enable = true;
                modules.normal.cli.fetches.fastfetch.enable = true;
            })

            (mkIf cfg2.normal.cli.util.all {
                modules.normal.cli.util.eza.enable = true;
                modules.normal.cli.util.tmux.enable = true;
                modules.normal.cli.util.pv.enable = true;
            })

            (mkIf cfg2.normal.media.productivity.programming.all {
                modules.normal.media.productivity.programming.git.enable = true;
                modules.normal.system.compute.all= true;
            })

            (mkIf cfg2.normal.system.compute.all {
                modules.normal.system.compute.compression.all = mkDefault true;
            })

            (mkIf cfg2.normal.system.compute.database.all {
                modules.normal.system.compute.database.sqlite.enable = mkDefault true;
            })

            (mkIf cfg2.normal.system.compute.compression.all {
                modules.normal.system.compute.compression.pigz.enable = true;
                modules.normal.system.compute.compression.unzip.enable = true;
                modules.normal.system.compute.compression.zlib.enable = true;
            })

            (mkIf cfg2.normal.system.compute.lang.all {
                modules.normal.system.compute.lang.c.all = true;
                modules.normal.system.compute.lang.haskell.all = true;
                modules.normal.system.compute.lang.util.all = true;
            })

            (mkIf cfg2.normal.system.compute.lang.c.all {
                modules.normal.system.compute.lang.c.cmake.enable = true;
                modules.normal.system.compute.lang.c.ninja.enable = true;
                modules.normal.system.compute.lang.c.gcc.enable = true;
                modules.normal.system.compute.lang.c.gnumake.enable = true;
                modules.normal.system.compute.lang.c.pkg-config.enable = true;
            })

            (mkIf cfg2.normal.system.compute.lang.haskell.all {
                modules.normal.system.compute.lang.haskell.cabal-install.enable = true;
                modules.normal.system.compute.lang.haskell.ghc.enable = true;
                modules.normal.system.compute.lang.haskell.digest.enable = true;
            })

            (mkIf cfg2.normal.system.compute.lang.util.all {
                modules.normal.system.compute.lang.util.libtool.enable = true;
            })

            (mkIf cfg2.normal.media.productivity.text-editors.gui.emacsGoodies {
                modules.normal.display.servers.xorg.util.xclip.enable = mkDefault true;
                modules.normal.display.servers.xorg.util.xdotool.enable = mkDefault true;
                modules.normal.display.servers.xorg.util.xwininfo.enable = mkDefault true;
                modules.normal.system.compute.compression.unzip.enable = mkDefault true;
                modules.normal.system.compute.database.sqlite.enable = mkDefault true;
                modules.normal.system.compute.lang.util.libtool.enable = mkDefault true;
                modules.normal.cli.shell.util.direnv.enable = mkDefault true;
                modules.normal.cli.shell.util.nix-direnv.enable = mkDefault true;
            })
        ]));
}
