{ options, config, lib, inputs, ... }:
with lib;
{
  imports = [
#    home-manager.nixosModules.home-manager
    ./waybar
  ];

#  options.home = with types; {
#    file = mkOption{  
#        description = "A set of files to be managed by home-manager's <option>home.file</option>."; 
#    };
#    configFile = mkOption {
#        description = "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";
#    }; 
#    programs = mkOption {description="Programs to be managed by home-manager.";};
#    extraOptions = mkOption {description="Options to pass directly to home-manager.";};
#  };
#
#  config = {
#    home.extraOptions = {
#      home.stateVersion = config.system.stateVersion;
#      home.file = mkAliasDefinitions options.home.file;
#      xdg.enable = true;
#      xdg.configFile = mkAliasDefinitions options.home.configFile;
#      programs = mkAliasDefinitions options.home.programs;
#    };##
#
 #   home-manager = {
 #     useUserPackages = true;

#      users.${config.user.name} =
#        mkAliasDefinitions options.home.extraOptions;
#    };
#  };
}