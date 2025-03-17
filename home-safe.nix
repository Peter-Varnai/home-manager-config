{ config, pkgs, ... }:

{

  home.username = "peter";
  home.homeDirectory = "/home/peter";

  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    htop

  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

  };

  targets.genericLinux.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
