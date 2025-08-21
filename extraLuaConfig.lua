
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.o.signcolumn = 'yes'
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.linebreak = true
vim.opt.wrap = false
vim.opt.mouse = 'a'
vim.opt.autoindent = true
vim.opt.cursorline = false
vim.opt.cmdheight = 1
vim.opt.breakindent = true
vim.opt.scrolloff = 12

vim.g.mapleader = " "

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input( "Grep > ") });
end)

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)
-- vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)


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
            visible = true,
            hide_gitignored = false,
            show_hidden_count = true,
            hide_dotfiles = false,
        },
    },
})

local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- LSP completions
        { name = 'luasnip' },  -- Snippet completions
    }, {
        { name = 'buffer' },   -- Buffer completions (words from the current file)
    }),

    mapping = cmp.mapping.preset.insert({
        -- Confirm selection
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item

        -- Navigate items in the list
        ['<C-n>'] = cmp.mapping.select_next_item(), -- Next item
        ['<C-p>'] = cmp.mapping.select_prev_item(), -- Previous item

        -- Scroll docs (if available)
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Snippet expansion
        ['<C-e>'] = cmp.mapping.abort(), -- Close completion window
    }),
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require'lspconfig'


-- Example for TypeScript (using tsserver)
lspconfig.ts_ls.setup {
    capabilities = capabilities,
}

-- Example for Rust (using rust_analyzer)
lspconfig.rust_analyzer.setup {
    -- cmd = { "/home/nixos/.nix-profile/bin/rust-analyzer" },
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
        },
    },
}

-- HTML LSP (vscode-html-language-server)
lspconfig.html.setup {
    capabilities = capabilities,
}

-- CSS LSP (vscode-css-language-server)
lspconfig.cssls.setup {
    capabilities = capabilities,
}

-- Nix LSP (nil)
lspconfig.nil_ls.setup {
    capabilities = capabilities,
}

lspconfig.lua_ls.setup {
    capabilities = capabilities,
}

-- GLSL configuration
lspconfig.glsl_analyzer.setup {
    capabilities = capabilities,
    filetypes = { "glsl", "vert", "frag", "comp", "tesc", "tese", "geom" },
}

vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
