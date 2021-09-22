{ pkgs, ... }:
{
  boot.blacklistedKernelModules = [];
  boot.initrd.kernelModules = [];
  boot.kernelPatches = [
   {
     name = "fix wifi regression";
     patch = ./wifi-fix1.patch;
   }
  ];
  boot.initrd.luks.devices.nixps.device = "/dev/disk/by-uuid/8693fd22-5b70-46e5-9bcd-61ab879aac3f";
  boot.kernelParams = [ "quiet" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.timeout = 1;
  boot.tmpOnTmpfs = true;
}
