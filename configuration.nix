{ config, pkgs, lib, ... }:
{
   imports =
    [
      ./boot.nix
      ./hardware-configuration.nix
      ./fonts.nix
      ./nix.nix
      ./users.nix
    ];

  networking = {
    hostName = "nixps";
    firewall.enable = true;
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    useDHCP = false;
  };

  time.timeZone = "Europe/Oslo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "nb_NO.UTF-8";
    };
  };

  console.keyMap = "no";

  nixpkgs.config.allowUnfree = true;  

  environment = {
    systemPackages = [ 
      pkgs.git
      pkgs.gnome3.gnome-tweaks 
    ];
    shells = [ pkgs.zsh ];
    variables = {
      EDITOR = "nano";
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };

  environment.etc."machine-id".source = "/nix/persist/etc/machine-id";
  
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.shell.app-switcher]
    current-workspace-only=true
  '';
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
       Experimental = true;
      };
    };
  };
  systemd.services.bluetooth.serviceConfig.ExecStart = [
    ""
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd ${lib.escapeShellArgs [ "-f" "/etc/bluetooth/main.conf" "-E" "-d" ]}"
  ];
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };
  hardware.firmware = with pkgs; [
    sof-firmware
    firmwareLinuxNonfree
    wireless-regdb
  ];

  programs.light.enable = true;
  programs.seahorse.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "python" "man" ];
    theme = "agnoster";
  };
  security.rtkit.enable = true;
  security.tpm2.enable = true;
  services.fwupd.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;
  # due to tlp
  services.power-profiles-daemon.enable = false;  
  services.upower.enable = true;
  # gnome stuff
  services.xserver.enable = true;
  services.xserver.layout = "no";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;  
  services.xserver.desktopManager.gnome.enable = true;  
  services.dbus.packages = [ pkgs.gnome3.dconf ];
  services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
  
  sound.mediaKeys.enable = true;
  sound.enable = true;

  system.stateVersion = "21.05";

  virtualisation.docker = { enable = true; enableOnBoot = true; };
}
