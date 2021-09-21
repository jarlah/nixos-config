{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    defaultKeymap = "viins";
    history = {
      extended = true;
      path = ".config/zsh/zsh_history";
    };
    dotDir = ".config/zsh";
    zplug = {
      enable = true;
      plugins = [
        {
          name = "zsh-users/zsh-history-substring-search";
        }
        {
          name = "zsh-users/zsh-syntax-highlighting";
          tags = [ "defer:2" ];
        }
        {
          name = "lib/git";
          tags = [ "from:oh-my-zsh" ];
        }
        {
          name = "plugins/git";
          tags = [ "from:oh-my-zsh" ];
        }
      ];
    };
  };
}