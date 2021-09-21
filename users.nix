{ pkgs, ... }:

{
  users = {
    mutableUsers = false;
    users = {
      root.initialHashedPassword = "$6$LqPfyI/FG6Q$YHxElCCC1cGM70f4f/UW8ZCg8N5R.3M9X5vfLyjto1f28KPPVaYCflYuUNViWiuh7G5uBp6yHG/84HkVw0RlS/";
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
          nodejs
          elmPackages.create-elm-app
          elmPackages.elm
          elmPackages.elm-test
          elmPackages.elm-format
          elmPackages.elm-review
          openssl
          slack
          spotify
          terraform
          vscode
          zoom-us
        ];
      };
      work = {
        description = "Work";
        extraGroups = [ "work" "wheel" "audio" "video" "networkmanager" "docker" ];
        shell = pkgs.zsh;
        home = "/home/work";
        isNormalUser = true;
        uid = 1002;
        initialHashedPassword = "$6$q7BSYxvDsnnWsfv$X8bskmu4/QRnQN.tI/fDUg3CTUWe/EgawHuDWwyt/B0cq3j4EUHwhMVOj35LWZryk73ZE06QHPFX3ExVjeThB/";
        packages = with pkgs ; [
          docker-compose
          gitAndTools.gh
          htop
          kubectl
          nodejs
          elmPackages.create-elm-app
          elmPackages.elm
          elmPackages.elm-test
          elmPackages.elm-format
          elmPackages.elm-review
          openssl
          slack
          spotify
          terraform
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
      work = {
        gid = 1002;
        members = [ "work" ];
      };
    };       
  };
}

