-- 1. OPCJE
-- ========================================================================== --
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


-- Key Maps
vim.g.maplocalleader = ","
vim.g.mapleader = " "

-- Powrót do normal mode
vim.keymap.set("i", "jj", "<ESC>", { silent = true })

-- Nawigacja po oknach
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-j>", "<C-w>j")

-- Zarządzanie oknami
vim.keymap.set("n", "<leader>b", "<CMD>vsplit<CR>")
vim.keymap.set("n", "<leader>d", "<CMD>split<CR>")

-- NeoTree
vim.keymap.set("n", "<leader>e", "<CMD>Neotree toggle<CR>")
vim.keymap.set("n", "<leader>r", "<CMD>Neotree focus<CR>")

-- ========================================================================== --
-- 2. BOOTSTRAP LAZY.NVIM
-- ========================================================================== --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ========================================================================== --
-- 3. KONFIGURACJA WTYCZEK 
-- ========================================================================== --
require("lazy").setup({
    -- Gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                terminal_colors = true,
                transparent_mode = true,
            })
            vim.cmd("colorscheme gruvbox")
        end,
    },

    -- Pasek statusu
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup()
        end,
    },

    -- Neo-tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            filesystem = {
                filtered_items = {
                    visible = true,
                }
            }
        }
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        end,
    },

    -- Narzędzia
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                filetypes = { "*" },
                user_default_options = {
                    mode = "background",
                    tailwind = true,
                    virtualtext = "■",
                },
            })
        end,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,
            })
        end,
    },

    -- Pomocnik skrótów
    {
      "folke/which-key.nvim",
      dependencies = { 'echasnovski/mini.nvim', version = false },
      event = "VeryLazy",
      config = function()
        require("which-key").setup()
      end,
    },

    -- Tryby edycji
    {
        "folke/zen-mode.nvim",
        opts = {
            window = { backdrop = 0.95, width = 120, height = 1 },
        }
    },
    {
        "folke/twilight.nvim",
        opts = {}
    },

})
