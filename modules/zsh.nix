{ config, pkgs, ... }:
{
  # Enables ZSH as the Default Shell
  users.defaultUserShell = pkgs.zsh;

  # Enables ZSH with Plugins
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  
   ohMyZsh = {
     enable = true;
     plugins = [ "git" ];
    };
  };
}
