{ config, lib, pkgs, ... }:
with lib;
let
    cfg = config.modules.normal.cli.shell.sshd;
in {
    options.modules.normal.cli.shell.sshd = {
        enable = mkEnableOption "Enable sshd";
        passAuth = mkOption {
            description = "Enable password authentication";
            type = types.bool;
            default = false;
        };
        port = mkOption {
            description = "what port to use. Defaults to.... default port.";
            type = types.int;
            default = 22;
        };
    };

    config = (mkMerge [
        (mkIf (cfg.enable) {
            services.sshd.enable = true;
            services.openssh.settings.PasswordAuthentication = cfg.passAuth;
            services.openssh.ports = [ cfg.port ];
        })
    ]);
}
