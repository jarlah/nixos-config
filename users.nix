{ pkgs, ... }:

{
  fileSystems."/home/jarlandre" =
    { device = "/nix/persist/home/jarlandre";
      fsType = "none";
      options = [ "bind" ];
    };

  fileSystems."/home/jarlah" =
    { device = "/nix/persist/home/jarlah";
      fsType = "none";
      options = [ "bind" ];
    };

  users = {
    mutableUsers = false;
    users = {
      jarlandre = {
        description = "Jarl André (Work)";
        extraGroups = [ "jarlandre" "wheel" "audio" "video" "networkmanager" "docker" ];
        shell = pkgs.zsh;
        home = "/home/jarlandre";
        isNormalUser = true;
        uid = 1001;
        initialHashedPassword = "$6$q7BSYxvDsnnWsfv$X8bskmu4/QRnQN.tI/fDUg3CTUWe/EgawHuDWwyt/B0cq3j4EUHwhMVOj35LWZryk73ZE06QHPFX3ExVjeThB/";
      };
      jarlah = {
        description = "Jarl André (Private)";
        extraGroups = [ "jarlah" "wheel" "audio" "video" "networkmanager" "docker" ];
        shell = pkgs.zsh;
        home = "/home/jarlah";
        isNormalUser = true;
        uid = 1002;
        initialHashedPassword = "$6$q7BSYxvDsnnWsfv$X8bskmu4/QRnQN.tI/fDUg3CTUWe/EgawHuDWwyt/B0cq3j4EUHwhMVOj35LWZryk73ZE06QHPFX3ExVjeThB/";
      };
    };
    groups = {
      jarlandre = {
        gid = 1001;
        members = [ "jarlandre" ];
      };
      jarlah = {
        gid = 1002;
        members = [ "jarlah" ];
      };
    };       
  };
}

