{ pkgs, ... }:
{
  boot.blacklistedKernelModules = [];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.luks.devices.nixps.device = "/dev/disk/by-uuid/f1c6f187-b09f-49b1-92ed-605680ab2b55";
  boot.kernelParams = [ "quiet" ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.timeout = 1;
  boot.tmpOnTmpfs = true;
}
