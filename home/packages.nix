{ pkgs, ... }:
{
    home.packages = [
        pkgs.docker-compose
        pkgs.gitAndTools.gh
        pkgs.htop
        pkgs.kubectl
        pkgs.elmPackages.create-elm-app
        pkgs.elmPackages.elm
        pkgs.elmPackages.elm-test
        pkgs.elmPackages.elm-format
        pkgs.elmPackages.elm-review
        pkgs.openssl
        pkgs.spotify
        pkgs.vscode
        pkgs.zoom-us
        pkgs.firefox
        pkgs.fzf
        pkgs.qemu
    ];
}