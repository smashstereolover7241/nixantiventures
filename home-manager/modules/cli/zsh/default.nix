{ pkgs, config, lib, inputs, ... }:
with lib;
let 
   cfg = config.teletypeOne.hm.zsh;
in
{
   options.teletypeOne.hm.zsh = {
      enable = mkEnableOption "Enable managed zsh"; 
   };
   config = mkIf cfg.enable (mkMerge [
      {
         programs.zsh = {
            enable = true;
            autosuggestion.enable = true;
            enableCompletion = true;
            syntaxHighlighting.enable = true;
            autocd = true;
            localVariables = {
               POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="5";
               POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="0";
               POWERLEVEL9K_STATUS_OK_BACKGROUND="8";
               POWERLEVEL9K_VCS_CLEAN_BACKGROUND="11";
               POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="8";
               POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="10";
               POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS="0.05";
               POWERLEVEL9K_VI_INSERT_MODE_STRING="INSERT" ;
               POWERLEVEL9K_VI_COMMAND_MODE_STRING="NORMAL";
               # POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time);
               POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS="()";
               ZLE_RPROMPT_INDENT="0";
            };
            
            plugins = [{
               name = "powerlevel10k";
               src = pkgs.zsh-powerlevel10k;
               file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }];

            oh-my-zsh = {
               enable = true;
               #theme = "powerlevel10k";
               plugins = [
                  "git"
                  "colorize"
                  "colored-man-pages"
                  #"command-not-found" #TODO: make work
               ];
            };

            shellAliases = {
               black = "sleep 1 && xset s activate"; # no longer works on wayland :|
               doas="doas --"; # well, doas is a thing
#              sudo="doas --"; # but not usually
               worksrv="ssh root@185.162.248.72 -p 20"; # what about using ssh aliases?
               vpn="sudo openvpn /home/localhost/localMain.ovpn"; # sure....
               #teamclick="xdotool click --delay 4000 --repeat 99999999 1"; # no longer need to fake mouseclicks, preserved
               neofetch="neofetch --ascii_distro arch | lolcat"; # historical, but a good one still
               vim="nvim";

               rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"; # rickroll required; it's broken tho

               ls="eza -al --color=always --group-directories-first"; # my preferred listing
               la="eza -a --color=always --group-directories-first";  # all files and dirs
               ll="eza -l --color=always --group-directories-first";  # long format
               lt="eza -aT --color=always --group-directories-first"; # tree listing

               #cp="cp -i";                          # confirm before overwriting something ## got too annoying
               df="df -h";                          # human-readable sizes
               grep="grep --colour=auto";
            };

            initExtra = ''
               source ~/.p10k.zsh
            '';
         };
         home.file.".p10k.zsh".source = ./p10k.zsh;
      }
   ]);
}
