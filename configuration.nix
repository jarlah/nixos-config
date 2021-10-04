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

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=2G" "mode=755" ];
    };

  fileSystems."/etc/nixos" =
    { device = "/nix/persist/etc/nixos";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/log" =
    { device = "/nix/persist/var/log";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/lib/docker" =
    { device = "/nix/persist/var/lib/docker";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/var/lib/NetworkManager" =
    { device = "/nix/persist/var/lib/NetworkManager";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/etc/NetworkManager/system-connections" =
    { device = "/nix/persist/etc/NetworkManager/system-connections";
      fsType = "none";
      options = [ "bind" ];
    };

  environment.etc."machine-id".source = "/nix/persist/etc/machine-id";

  networking = {
    hostName = "nixps";
    firewall.enable = true;
    networkmanager.enable = true;
    #networkmanager.wifi.backend = "iwd";
    #useDHCP = true;
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
      pkgs.alacritty 
      pkgs.haskellPackages.xmobar
      pkgs.feh
      pkgs.rofi
      pkgs.gmrun
      pkgs.xscreensaver
      pkgs.shutter
      pkgs.xorg.xmessage
      pkgs.stack
      pkgs.ghc
      pkgs.hlint
      pkgs.autorandr
      pkgs.arandr
      pkgs.gnomeExtensions.appindicator
      pkgs.gnomeExtensions.dash-to-dock
      pkgs.slack
      (pkgs.python3.withPackages(ps: [ ps.pyyaml ps.requests ]))
      pkgs.google-cloud-sdk
      pkgs.jq
    ];
    shells = [ pkgs.zsh ];
    variables = {
      EDITOR = "nano";
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };

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
    package = pkgs.pulseaudioFull;
  };

  programs.steam.enable = true;
  programs.fuse.userAllowOther = true;
  programs.light.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "python" "man" ];
    theme = "agnoster";
  };
  security.rtkit.enable = true;
  security.tpm2.enable = true;
  services.fwupd.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;
  services.upower.enable = true;

  services.logind.lidSwitchExternalPower = "ignore";

  services.xserver = {
    enable = true;
    layout = "no";
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages : [
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
        ];
      };
    };
    #desktopManager.gnome.enable = true;
    displayManager.lightdm.enable = false;
    displayManager.startx.enable = true;
    #displayManager.gdm.enable = true;
    displayManager.defaultSession = "none+xmonad";
  };

  services.dbus.packages = [ pkgs.gnome3.dconf ];
  services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
  services.power-profiles-daemon.enable = false;

  services.picom.enable = true;
  services.picom.backend = "glx";
  services.picom.vSync = true;
  
  sound.mediaKeys.enable = true;
  sound.enable = true;

  system.stateVersion = "21.05";

  virtualisation.docker = { enable = true; enableOnBoot = true; };
}
