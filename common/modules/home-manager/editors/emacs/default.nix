{ pkgs, config, lib, inputs, ... }:
with lib;
let 
    cfg = config.real.home-manager.editors.emacs;
    envExtra = ''
        export PATH="${config.xdg.configHome}/emacs/bin:$PATH"
    '';
    customEmacsPackages = emacs: ((pkgs.emacsPackagesFor emacs).emacsWithPackages (epkgs: [ epkgs.vterm ])); # don't compile vertm from source on first launch
in
{
    options.config.real.home-manager.editors.emacs = {
        enable = mkEnableOption "Enable managed doom-emacs";
        username = mkOption {
            description = "What user to apply this to. Defaults to default user.";
            type = types.str;
        };
    };
    config = mkIf cfg.enable (mkMerge [
        (let
            emacsPkg = customEmacsPackages pkgs.emacs29;
        in
        {
            home-manager.users.${cfg.username} = {
                home.packages = with pkgs; [
                    git
                    (ripgrep.override {withPCRE2 = true;})
                    gnutls

                    fd
                    imagemagick
                    fd
                    zstd
                    rsync

                    emacsPkg
                ];

                programs.zsh.envExtra = envExtra; #doom is now on path :) ## do not forget to doom sync

                xdg.configFile."doom" = {
                    source = ./doomConfig;
                    force = true;
                };
                home.activation.installDoomEmacs = lib.hm.dag.entryAfter ["writeBoundary"] ''
                    ${pkgs.rsync}/bin/rsync -avz --chmod=D2755,F744 ${inputs.doomemacs}/ ${config.xdg.configHome}/emacs/
                    # maybe auto sync here
                '';
            };
        })
    ]);
}
