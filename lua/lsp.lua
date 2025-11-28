-- ~/.config/nvim/lua/lsp.lua

-- Define capabilities (integrate with blink.cmp)
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- 1. Configure BasedPyright (Type Checking & Hover)
vim.lsp.config('basedpyright', {
  cmd = { 'basedpyright-langserver', '--stdio' },
  root_markers = { 'pyproject.toml', 'setup.py', '.git' },
  capabilities = capabilities,
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        autoSearchPaths = true,
      }
    }
  }
})

-- 2. Configure Ruff (Linting & Formatting)
vim.lsp.config('ruff', {
  cmd = { 'ruff', 'server' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.git' },
  capabilities = capabilities,
  init_options = {
    settings = {
      -- Ruff specific settings
    }
  }
})

-- 3. Enable Servers
-- This registers the filetype autocommands to start the servers
vim.lsp.enable('basedpyright')
vim.lsp.enable('ruff')

-- 4. Native Formatting (Format on Save)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    
    -- Prefer Ruff for formatting if attached
    if client.name == 'ruff' then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ id = client.id })
        end,
      })
    end
    
    -- Disable BasedPyright formatting to avoid conflicts
    if client.name == 'basedpyright' then
      client.server_capabilities.documentFormattingProvider = false
    end
  end,
})
