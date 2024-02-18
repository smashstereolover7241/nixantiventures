{ pkgs, config, lib, inputs, ... }:
with lib;
let 
   cfg = config.teletypeOne.hm.hyprland;
in
{
   imports = [
	  ./modules
   ];
   options.teletypeOne.hm.hyprland = {
      enable = mkEnableOption "Enable hyprland n shit, just not hyprland itself atm....";
      full = mkOption {
         description = "Change utils to opt-out";
      };
      scaling = mkOption {
         description = "Change scaling for all screens";
	 type = types.str;
	 default = "1";
      };
   };
   config = mkIf cfg.enable (mkMerge [
      {
         wayland.windowManager.hyprland.enable = true;
         wayland.windowManager.hyprland = {
	    xwayland.enable = true;
	    settings = {

               "$terminal" = "kitty";
	       "$fileManager" = "nemo";
	       "$menu" = "wofi --show drun";
	       "env" = [
	          "XCURSOR_SIZE,24"
		  "QT_QPA_PLATFORMTHEME,qt5ct"
		];

               monitor = [
	          ",preferred,auto,${cfg.scaling}"
	       ];

               xwayland = {
                  force_zero_scaling = true;
               };

	       input = {
                  kb_layout = "de";
                  kb_variant = "";
                  kb_model = "";
                  kb_options = "";
                  kb_rules = "";
                  follow_mouse = 1;
#		  accel_profile = "flat";
                  touchpad = {
                     natural_scroll = 0;
                  };
                  sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
               };

	       general = {
                  gaps_in = 5;
                  gaps_out = 10;
                  border_size = 2;
                  "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                  "col.inactive_border" = "rgba(595959aa)";
                  layout = "dwindle";
                  allow_tearing = false;
               };

	       decoration = {
                  rounding = 10;
                  blur = {
                     enabled = true;
                     size = 3;
                     passes = 1;
                  };
                 drop_shadow = true;
                 shadow_range = 4;
                 shadow_render_power = 3;
                 "col.shadow" = "rgba(1a1a1aee)";
               };

	       animations = {
                  enabled = true;
                  bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
                  animation = [
		     "windows, 1, 7, myBezier"
                     "windowsOut, 1, 7, default, popin 80%"
                     "border, 1, 10, default"
                     "borderangle, 1, 8, default"
                     "fade, 1, 7, default"
                     "workspaces, 1, 6, default"
		  ];
               };

	       misc = {
                  vfr = true; # misc:no_vfr -> misc:vfr. bool, heavily recommended to leave at default on. Saves on CPU usage.
                  vrr = false; # misc:vrr -> Adaptive sync of your monitor. 0 (off), 1 (on), 2 (fullscreen only). Default 0 to avoid white flashes on select hardware.
               };

	       dwindle = {
                  pseudotile = true; # enable pseudotiling on dwindle
                  force_split = 0;
                  preserve_split = true;
                  default_split_ratio = 1.0;
                  no_gaps_when_only = false;
                  special_scale_factor = 0.8;
                  split_width_multiplier = 1.0;
                  use_active_for_splits = true;
               };

	       master = {
                  mfact = 0.5;
                  orientation = "right";
                  special_scale_factor = 0.8;
                  new_is_master = true;
                  no_gaps_when_only = false;
               };

	       gestures = {
                  workspace_swipe = true;
	       };

	       debug = {
                  damage_tracking = 2; # leave it on 2 (full) unless you hate your GPU and want to make it suffer!
               };

	       exec-once = [
	          "waybar &"
		  "swayidle &"
		  "hyprpaper &"
	       ];

	       "$mainMod" = "SUPER";

	       bind = [
                  "$mainMod, m, exec, $terminal ncmpcpp"
                  "$mainMod, q, killactive"
                  "$mainMod, r, exec, rofi-theme-selector"
                  "$mainMod, t, exec, $terminal  "
                  "$mainMod, comma, exec, pavucontrol"
                  "$mainMod, x, exec, oblogout"
                  #"$mainMod, Escape, exec, xkill # not a thing anymore"
                  "$mainMod, Escape, killactive"
                  "$mainMod, Return, exec, $terminal"
                  "$mainMod, F11, exec, $menu "
                  "$mainMod, F12, exec, $menu"
                  "$mainMod, i, exec, emacs"
                  
                  # Super shift
                  "SUPER_SHIFT, h, exec, $terminal htop"
                  "SUPER_SHIFT, Return, exec, $fileManager "
                  #"SUPER_SHIFT, r, exec, $ "xmonad --recompile && xmonad --restart" # nope!"
                  "SUPER_SHIFT, q, killactive"
                  "SUPER_SHIFT, x, exit"
                  
                  # CTRL ALT
                  
                  "CONTROLALT, a, exec, rofi"
                  #"CONTROLALT, comma, exec, catfish #TODO"
                  "CONTROLALT, f, exec, env MOZ_USE_XINPUT2=1 firefox"
                  "CONTROLALT, g, exec, chromium -no-default-browser-check"
                  #"CONTROLALT, i, nitrogen #TODO: search alternative"
                  "CONTROLALT, l, exec, betterlockscreen -l blur"
                  "CONTROLALT, r, exec, rofi-theme-selector"
                  "CONTROLALT, t, exec, kitty "
                  "CONTROLALT, u, exec, pavucontrol"
                  "CONTROLALT, Return, exec, $fileManager"
                  
                  # CTRL SHIFT
                  "CONTROLSHIFT, Print, exec, gnome-screenshot -i"
                  
                  #Alt
                  "ALT, F2, exec, [float] gmrun "
                  "ALT, F3, exec, $menu"
                  
                  # Brightness
                  ", XF86MonBrightnessUp, exec, light -A 5%"
                  ", XF86MonBrightnessDown, exec, light -U 5%"

                  # Layout
                  "$mainMod, Space, togglesplit, # dwindle"
                  
                  # Example "see https://wiki.hyprland.org/Configuring/Binds/ for more"
                  #"$mainMod, Q, exec, $terminal"
                  #"$mainMod, C, killactive, "
                  #"$mainMod, M, exit, "
                  "$mainMod, E, exec, $fileManager"
                  "$mainMod, V, togglefloating"
                  "$mainMod, R, exec, $menu"
                  "$mainMod, P, pseudo, # dwindle"
                  
                  # Move focus with mainMod + arrow keys
                  "$mainMod, left, movefocus, l"
                  "$mainMod, right, movefocus, r"
                  "$mainMod, up, movefocus, u"
                  "$mainMod, down, movefocus, d"
                  
                  # Move focus with main keys
                  "$mainMod, h, movefocus, l"
                  "$mainMod, l, movefocus, r"
                  "$mainMod, k, movefocus, u"
                  "$mainMod, j, movefocus, d"
                  
                  # Switch workspaces with mainMod + [0-9]
                  "$mainMod, 1, workspace, 1"
                  "$mainMod, 2, workspace, 2"
                  "$mainMod, 3, workspace, 3"
                  "$mainMod, 4, workspace, 4"
                  "$mainMod, 5, workspace, 5"
                  "$mainMod, 6, workspace, 6"
                  "$mainMod, 7, workspace, 7"
                  "$mainMod, 8, workspace, 8"
                  "$mainMod, 9, workspace, 9"
                  "$mainMod, 0, workspace, 10"
                  
                  # Alt workspaces (last 5)
                  "ALT, 1, workspace, 11"
                  "ALT, 2, workspace, 12"
                  "ALT, 3, workspace, 13"
                  "ALT, 4, workspace, 14"
                  "ALT, 5, workspace, 15"
                  "ALT SHIFT, 1, movetoworkspace, 11"
                  "ALT SHIFT, 2, movetoworkspace, 12"
                  "ALT SHIFT, 3, movetoworkspace, 13"
                  "ALT SHIFT, 4, movetoworkspace, 14"
                  "ALT SHIFT, 5, movetoworkspace, 15"
                  
                  # Move active window to a workspace with mainMod + SHIFT + [0-9]
                  "$mainMod SHIFT, 1, movetoworkspace, 1"
                  "$mainMod SHIFT, 2, movetoworkspace, 2"
                  "$mainMod SHIFT, 3, movetoworkspace, 3"
                  "$mainMod SHIFT, 4, movetoworkspace, 4"
                  "$mainMod SHIFT, 5, movetoworkspace, 5"
                  "$mainMod SHIFT, 6, movetoworkspace, 6"
                  "$mainMod SHIFT, 7, movetoworkspace, 7"
                  "$mainMod SHIFT, 8, movetoworkspace, 8"
                  "$mainMod SHIFT, 9, movetoworkspace, 9"
                  "$mainMod SHIFT, 0, movetoworkspace, 10"
                  
                  # Example special workspace (scratchpad)
                  # TODO: maybe use?
                  #"$mainMod, S, togglespecialworkspace, magic"
                  #"$mainMod SHIFT, S, movetoworkspace, special:magic"
                  
                  # Scroll through existing workspaces with mainMod + scroll
                  "$mainMod, mouse_down, workspace, e+1"
                  "$mainMod, mouse_up, workspace, e-1"
	       ];

	       bindm = [
                  "$mainMod, mouse:272, movewindow"
                  "$mainMod, mouse:273, resizewindow"
	       ];
	    };
	 };
      }
      (mkIf cfg.full {
         # enable all the things
	 teletypeOne.hm.hyprland.swayidle.enable = true;
	 teletypeOne.hm.hyprland.swaylock.enable = true;
	 teletypeOne.hm.hyprland.hyprpaper.enable = true;
      })
   ]);
}
