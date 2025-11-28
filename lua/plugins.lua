-- ~/.config/nvim/lua/plugins.lua

-- Native plugin declaration
vim.pack.add({
  -- Core Dependencies
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  
  -- Completion Engine (Rust-based)
  { 
    src = 'https://github.com/saghen/blink.cmp',
    version = 'v1.8.0', -- Pin to stable release
    build = 'cargo build --release' 
  },

  -- Syntax Highlighting (Note: 'main' branch required for v0.12)
  { 
    src = 'https://github.com/nvim-treesitter/nvim-treesitter', 
    branch = 'main',
    build = ':TSUpdate' 
  },

  -- External Binary Manager (for installing Pyright/Ruff binaries)
  { src = 'https://github.com/williamboman/mason.nvim' },
  
  -- Optional: Colorscheme
  { src = 'https://github.com/folke/tokyonight.nvim' },
})

-- Load the colorscheme immediately
vim.cmd.colorscheme('tokyonight')
require('mason').setup()
