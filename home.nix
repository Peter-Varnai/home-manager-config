{ config, pkgs, inputs, ... }:

{
  home.username = "peter";
  home.homeDirectory = "/home/peter";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neofetch
    eza
    fzf
    ripgrep
    git
    tree-sitter
    # cargo
    # rust-analyzer
    clang
    rustup
    cargo-watch
    xsel
    nil
    jq
    zip
    pkg-config
    
    # node packages
    nodejs_23
    # nodePackages.gltf-pipeline


    # apacheKafka_3_7

     # Nerd Fonts (specific fonts for development)
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono

    # nerd-fonts.source-code-pro
    nerd-fonts.droid-sans-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.ubuntu-mono
    nerd-fonts.roboto-mono  

    #lsp packagdes
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    # rust-analyzer
    lua-language-server
    glslang
    glsl_analyzer

  ]; 

  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          own-onedark-nvim = prev.vimUtils.buildVimPlugin {
            name = "onedark";
            src = inputs.plugin-onedark;
          };
        };
      })
    ]; 
  };

  programs.starship.enable = true;

  programs.bash.enable = true;

  programs.git = {
      enable = true;
      userName = "Peter-Varnai";
      userEmail = "peter@varnai.dev";
      
      extraConfig = {
        credential.helper = "cache";
      };
  };

  programs.home-manager.enable = true;
}
