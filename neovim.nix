{ config, pkgs, ... }:

{
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    # toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      lspkind-nvim
      luasnip
      cmp_luasnip 

      {
      plugin = neo-tree-nvim;
        type = "lua";
            config = ''
                require("neo-tree").setup({
                position = 'right',
                filesystem = {
                filtered_items = {
                visible = true,                    
                hide_dotfiles = false,
                hide_gitignored = false, 
              },
            },
          })
        '';
        }
        plenary-nvim
        nvim-web-devicons
        nui-nvim

        {
          plugin = onedarker-nvim;
          config = "colorscheme onedarker";
        }

        {
          plugin = comment-nvim;
          config = toLua ''require('Comment').setup()'';
        }

        nvim-treesitter
        nvim-treesitter-refactor

        {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
            p.tree-sitter-rust
          ]));
        }

        {
          plugin = telescope-nvim;
          config = toLua ''
            require('telescope').setup({
              extensions = {
                fzf = {
                  fuzzy = true,                    
                  override_generic_sorter = true, 
                  override_file_sorter = true,   
                  case_mode = "smart_case",     
                  }
              }
            })

            require('telescope').load_extension('fzf')
          '';
        }

        telescope-fzf-native-nvim  
      ];

      #init.lua
      extraLuaConfig = ''
        ${builtins.readFile ./extraLuaConfig.lua}
      '';
    };
  }
