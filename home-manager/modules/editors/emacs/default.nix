{ pkgs, config, lib, inputs, ... }:
with lib;
let 
   cfg = config.teletypeOne.hm.zsh;
   envExtra = ''
     export PATH="${config.xdg.configHome}/emacs/bin:$PATH"
     '';
     customEmacsPackages = emacs: ((pkgs.emacsPackagesFor emacs).emacsWithPackages (epkgs: [ epkgs.vterm ])); # no more compiling vterm when launching it
in
{
   options.teletypeOne.hm.editors.emacs = {
      enable = mkEnableOption "Enable managed doom-emacs"; 
   };
   config = mkIf cfg.enable (mkMerge [
      (let
         emacsPkg = customEmacsPackages pkgs.emacs29;
      in
      {
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
      })
   ]);
}
