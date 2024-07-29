{ pkgs, config, lib, inputs, ... }:
with lib;
let 
   cfg = config.teletypeOne.hm.sway.swaylock;
in
{
   options.teletypeOne.hm.sway.swaylock = {
      enable = mkEnableOption "Enable swaylock; As it is (seemingly) not possible to enable the swaylock fix via the home module, remember to activate it manually!";
   };
   config = mkIf cfg.enable {
      programs.swaylock.enable = true;
      programs.swaylock.package = pkgs.swaylock-effects;
      xdg = {
        configFile = {
          "swaylock/config".text = ''
              image=~/papers/a.png
              fade-in=0.4
              font="Cascadia Code"
              clock
              indicator
              indicator-radius=150
              indicator-thickness=8
              line-color=181825
              ring-color=181825
              inside-color=181825
              key-hl-color=cba6f7
              separator-color=00000000
              text-color=cdd6f4
              text-caps-lock-color=""
              line-ver-color=cba6f7
              ring-ver-color=cba6f7
              inside-ver-color=181825
              text-ver-color=cdd6f4
              ring-wrong-color=f38ba8
              text-wrong-color=f38ba8
              inside-wrong-color=181825
              inside-clear-color=181825
              text-clear-color=cdd6f4
              ring-clear-color=cba6f7
              line-clear-color=181825
              line-wrong-color=181825
              bs-hl-color=f38ba8
              datestr="%d.%m"
              effect-blur=10x4
            '';
          };
      };
   };
}

