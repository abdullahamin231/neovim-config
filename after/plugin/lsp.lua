local lsp = require('lsp-zero').preset({})

-- Ensure Mason and LSP are set up properly
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'clangd' },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})

require('lspconfig').lua_ls.setup({
	settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }, -- Recognize `vim` as a global variable
            },
            workspace = {
                library = {
                    vim.api.nvim_get_runtime_file("", true) -- Make Lua LS aware of Neovim runtime files
                }
            }
        }
    }
})

-- LSP Keybindings
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end)

-- Setup LSP
lsp.setup()

-- Setup Completion
local cmp = require('cmp')

cmp.setup({
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    }
})

-- Setup null-ls AFTER LSP setup
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- C/C++
        null_ls.builtins.formatting.clang_format,
        -- React / TypeScript
        null_ls.builtins.formatting.prettier,
    },
})

-- Proper format command
vim.api.nvim_set_keymap("n", "<leader>f", ":lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true })

