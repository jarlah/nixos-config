{
  imports = [
    ./home/starship.nix
    ./home/zsh.nix
  ];
  programs.firefox.enable = true;
  programs.fzf.enable = true;
  programs.htop.enable = true;
}
