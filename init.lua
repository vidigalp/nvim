-- ~/.config/nvim/init.lua

-- 1. Load Plugins (Must be first to ensure dependencies are available)
require('plugins')

-- 2. Load Core Configurations
require('treesitter')
require('lsp')
require('completion')

-- 3. Basic Settings
vim.opt.number = true
vim.opt.cmdheight = 0 -- Native v0.12 feature [1, 2]
