{ config, lib, pkgs, ... }:
with lib;
let
    cfg = config.modules.normal.system.storage.remoteUnlock;
in {
    options.modules.normal.system.storage.remoteUnlock = {
        enable = mkEnableOption "Enable sshd";

        port = mkOption {
            description = "what port to use. Defaults to.... default port.";
            type = types.int;
            default = 22;
        };

        netDrivers = mkOption {
            description = "list of required drivers for network";
            type = types.listOf (types.str);
            default = [ "virtio_net" ];
        };

        authorizedKeys = mkOption {
            description = "list of keys allowed to attempt unlock";
            type = types.listOf (types.str);
            default = [ ];
        };
    };

    config = (mkMerge [
        (mkIf (cfg.enable) {
            boot.initrd = {
                availableKernelModules = cfg.netDrivers;
                network = {
                    enable = true;
                    udhcpc.enable = true;
                    flushBeforeStage2 = true;
                    ssh = {
                        enable = true;
                        port = cfg.port;
                        authorizedKeys = cfg.authorizedKeys;
                        hostKeys = [ "/etc/secrets/initrd/ssh_host_ed25519_key" ];
                    };
                    postCommands = ''
                        # Automatically ask for the password on SSH login
                        echo 'cryptsetup-askpass || echo "Unlock was successful; exiting SSH session" && exit 1' >> /root/.profile
                    '';
                };
            };
        })
    ]);
}
