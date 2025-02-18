-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Completion framework:
    use 'hrsh7th/nvim-cmp'

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'
    use({
        'rebelot/kanagawa.nvim',
        as = 'kanagawa',
        config = function()
            --           -- optionally, use dragon for a darker theme
            vim.cmd('colorscheme kanagawa')
        end
    })


    use({ "typicode/bg.nvim", lazy = false })
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            { 'hrsh7th/nvim-cmp' },                  -- Required for autocompletion
            { 'hrsh7th/cmp-nvim-lsp' },              -- Required
            { 'L3MON4D3/LuaSnip' },                  -- Required for snippets
        }
    }
    use {
        'nvimtools/none-ls.nvim', -- Previously null-ls
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    -- nvim v0.7.2
    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })


    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                signs = true,      -- show icons in the signs column
                sign_priority = 8, -- sign priority
                -- keywords recognized as todo comments
                keywords = {
                    FIX = {
                        icon = " ", -- icon used for the sign, and in search results
                        color = "error", -- can be a hex color, or a named color (see below)
                        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                        -- signs = false, -- configure signs for some keywords individually
                    },
                    TODO = { icon = " ", color = "info" },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                    TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
                },
                gui_style = {
                    fg = "NONE",       -- The gui style to use for the fg highlight group.
                    bg = "BOLD",       -- The gui style to use for the bg highlight group.
                },
                merge_keywords = true, -- when true, custom keywords will be merged with the defaults
                -- highlighting of the line containing the todo comment
                -- * before: highlights before the keyword (typically comment characters)
                -- * keyword: highlights of the keyword
                -- * after: highlights after the keyword (todo text)
                highlight = {
                    multiline = true,                -- enable multine todo comments
                    multiline_pattern = "^.",        -- lua pattern to match the next multiline from the start of the matched keyword
                    multiline_context = 10,          -- extra lines that will be re-evaluated when changing a line
                    before = "",                     -- "fg" or "bg" or empty
                    keyword = "wide",                -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                    after = "fg",                    -- "fg" or "bg" or empty
                    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
                    comments_only = true,            -- uses treesitter to match keywords in comments only
                    max_line_len = 400,              -- ignore lines longer than this
                    exclude = {},                    -- list of file types to exclude highlighting
                },
                -- list of named colors where we try to extract the guifg from the
                -- list of highlight groups or use the hex color if hl not found as a fallback
                colors = {
                    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                    info = { "DiagnosticInfo", "#2563EB" },
                    hint = { "DiagnosticHint", "#10B981" },
                    default = { "Identifier", "#7C3AED" },
                    test = { "Identifier", "#FF00FF" }
                },
                search = {
                    command = "rg",
                    args = {
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                    },
                    -- regex that will be used to match keywords.
                    -- don't replace the (KEYWORDS) placeholder
                    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
                },
            }
        end
    }
end)
