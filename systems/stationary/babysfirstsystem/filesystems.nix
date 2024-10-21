{
 fileSystems."/" =
    { device = "ssdFS";
      fsType = "zfs";
    };

  fileSystems."/nix" =
    { device = "ssdFS/nix";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "ssdFS/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/732c1ff9-d271-42ec-af66-226e4c1c3064";
      fsType = "ext4";
    };

}
