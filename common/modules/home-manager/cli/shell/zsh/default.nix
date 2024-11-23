{ pkgs, config, lib, inputs, options, ... }:
with lib;
let cfg = config.real.home-manager.cli.shell.zsh;
in

{
  options.real.home-manager.cli.shell.zsh = {
    enable = mkEnableOption "Enable managed zsh";
    username = mkOption {
        description = "What user to apply this to. Defaults to default user.";
        type = types.str;
    };
  };

  config = mkIf cfg.enable (mkMerge [
  {
    home-manager.users.${cfg.username} = {
      programs.zsh = {
        enable = true;
        autocd = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        autosuggestion.enable = true;
        localVariables = {
          POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="0";
          POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="5";
          POWERLEVEL9K_STATUS_OK_BACKGROUND="8";
          POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="8";
          POWERLEVEL9K_VCS_CLEAN_BACKGROUND="11";
          POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS="0.05";
          POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="10";
          POWERLEVEL9K_VI_COMMAND_MODE_STRING="NORMAL";
          POWERLEVEL9K_VI_INSERT_MODE_STRING="INSERT" ;
          # POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time);
          ZLE_RPROMPT_INDENT="0";
          POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS="()";
        };

        plugins = [{
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }];

        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "colorize"
            "colored-man-pages"
            #"command-not-found" #TODO: make work
          ];
        };

        shellAliases = {
          black = "sleep 1 && xset s activate"; # no longer works on wayland :| (xmonad rules!)
          doas="doas --"; # well, doas is a thing
          #              sudo="doas --"; # but not usually
          #teamclick="xdotool click --delay 4000 --repeat 99999999 1"; # no longer need to fake mouseclicks, preserved
          neofetch="neofetch --ascii_distro arch | lolcat"; # historical, but a good one still
          vim="nvim";

          lt="eza -aT --color=always --group-directories-first"; # tree listing
          ls="eza -al --color=always --group-directories-first"; # my preferred listing
          ll="eza -l --color=always --group-directories-first";  # long format
          la="eza -a --color=always --group-directories-first";  # all files and dirs

          df="df -h";                          # human-readable sizes
          grep="grep --colour=auto";
        };
        initExtra = ''
        source ~/.p10k.zsh
        '';
      };
      home.file.".p10k.zsh".source = ./p10k.zsh;
    };
  }]);
}
