-- ~/.config/nvim/lua/completion.lua
local blink = require('blink.cmp')

blink.setup({
  keymap = { preset = 'default' },

  -- REQUIRED FIX for vim.pack installations:
  fuzzy = {
    prebuilt_binaries = {
      -- Force usage of the specific version tag (Must match the version in plugins.lua)
      -- Current stable as of Nov 2025 is v1.8.0
      force_version = 'v1.8.0',
      -- Ensure we download the binary if missing
      download = true,
    }
  },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  snippets = {
    preset = 'default',
  },
})
