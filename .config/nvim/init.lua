-- OPCJE NEOVIMA
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 5
vim.opt.virtualedit = "block"
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- SKROTY KLAWISZOWE
-- LSP: nawigacja i pomoc
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: dokumentacja" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: definicja" })
vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "LSP: użycia symbolu" })
vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "LSP: zmień nazwę" })
vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "LSP: akcje kodu" })
-- Leader Key 
vim.g.mapleader = " "
vim.g.maplocalleader = ","
-- Powrot do normal mode
vim.keymap.set("i", "jj", "<Esc>", { silent = true })
-- Nawigacja po oknach
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-j>", "<C-w>j")
-- Zarzadzanie oknami
vim.keymap.set("n", "<leader>b", "<CMD>vsplit<CR>")
vim.keymap.set("n", "<leader>d", "<CMD>split<CR>")

-- WTYCZKI
-- vim.pack pobiera i aktualizuje wtyczki
vim.pack.add({
    -- Zaleznosci wtyczek
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",

    -- Wyglad
    "https://github.com/ellisonleao/gruvbox.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",

    -- Wyszukiwanie plikow i tekstu
    {
        src = "https://github.com/nvim-telescope/telescope.nvim",
        version = "0.1.8",
    },

    -- Narzedzia edycyjne
    "https://github.com/NvChad/nvim-colorizer.lua",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/folke/which-key.nvim",

    -- Markdown: czytelne renderowanie dokumentów
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",

    -- Mason: instalacja narzedzi i serwerow
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",

    -- LSP: konfiguracje serwerow dla Neovima
    "https://github.com/neovim/nvim-lspconfig",

    -- Autouzupelnianie
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
}, { load = true })

-- MOTYW I INTERFEJS
require("gruvbox").setup({
    terminal_colors = true,
    transparent_mode = true,
})

vim.cmd.colorscheme("gruvbox")

require("lualine").setup()

-- TELESCOPE: WYSZUKIWANIE
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)

-- NARZEDZIA EDYCYJNE
require("colorizer").setup({
    filetypes = { "*" },
    user_default_options = {
        mode = "background",
        tailwind = true,
        virtualtext = "■",
    },
})

-- Automatyczne nawiasy
require("nvim-autopairs").setup()

-- Podpowiedzi skrotow
require("which-key").setup()

-- MASON: INSTALACJA SERWEROW LSP
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",       -- Lua
        "bashls",       -- Bash
        "basedpyright", -- Python
        "clangd",       -- C i C++
        "jsonls",       -- JSON
        "cssls",        -- CSS
        "html",         -- HTML
        "taplo",        -- TOML
    },
})

-- LSP: KONFIGURACJA SERWEROW
-- Informacje potrzebne LSP do wspolpracy z nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities,
})

-- Ustawienia Lua, szczegolnie przydatne do konfiguracji Neovima
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
vim.lsp.enable({
    "lua_ls",
    "bashls",
    "basedpyright",
    "clangd",
    "jsonls",
    "cssls",
    "html",
    "taplo",
})
-- NVM-CMP: AUTOUZUPEŁNIANIE
local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- Korzystamy z wbudowanej obslugi snippetow Neovima
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
    }),
})

-- MARKDOWN: RENDEROWANIE
require("render-markdown").setup({})


