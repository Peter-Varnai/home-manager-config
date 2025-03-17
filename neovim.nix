{ config, pkgs, ... }:

{
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
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

          config = toLua ''
            local function toggle_neotree()
            if vim.bo.filetype == "neo-tree" then
            require("neo-tree.command").execute({ action = "close" })
            else
            require("neo-tree.command").execute({ action = "focus", source = "filesystem" })
            end
            end

            vim.keymap.set('n', '<M-1>', toggle_neotree, { noremap = true, silent = true })


            require('nvim-web-devicons').setup()

            require('neo-tree').setup({
            close_if_last_window = true,
            filesystem = {
            filtered_items = {
            show_hidden_count = true,
            hide_dotfiles = false,
            },
            },
            })
          '';
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
        
       # vim-nix

      ];

      #init.lua
      extraLuaConfig = ''
        ${builtins.readFile ./extraLuaConfig.lua}
      '';
    };

  }
