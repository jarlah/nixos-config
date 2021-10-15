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
    initExtra = ''
      export PATH="$HOME/.cargo/bin:$PATH"
    '';
  };
}