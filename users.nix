{ pkgs, ... }:

{
  users = {
    mutableUsers = false;
    users = {
      jarlandre = {
        description = "Jarl André Hübenthal";
        extraGroups = [ "jarlandre" "wheel" "audio" "video" "networkmanager" "docker" ];
        shell = pkgs.zsh;
        home = "/home/jarlandre";
        isNormalUser = true;
        uid = 1001;
        initialHashedPassword = "$6$q7BSYxvDsnnWsfv$X8bskmu4/QRnQN.tI/fDUg3CTUWe/EgawHuDWwyt/B0cq3j4EUHwhMVOj35LWZryk73ZE06QHPFX3ExVjeThB/";
        packages = with pkgs ; [
          docker-compose
          gitAndTools.gh
          htop
          kubectl
          elmPackages.create-elm-app
          elmPackages.elm
          elmPackages.elm-test
          elmPackages.elm-format
          elmPackages.elm-review
          openssl
          spotify
          vscode
          zoom-us
        ];
      };
    };
    groups = {
      jarlandre = {
        gid = 1001;
        members = [ "jarlandre" ];
      };
    };       
  };
}

