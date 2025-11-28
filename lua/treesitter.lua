-- ~/.config/nvim/lua/treesitter.lua
local ts = require("nvim-treesitter")

-- 1. Define languages to ensure
local ensure_list = { 
  "c", "lua", "vim", "vimdoc", "query", "python", "markdown", "markdown_inline" 
}

-- 2. Helper to check if a parser library exists in 'runtimepath'
--    (Replaces the deprecated api.get_parser_info)
local function is_installed(lang)
  -- Look for parser/<lang>.so (or.dll/.dylib)
  local found = vim.api.nvim_get_runtime_file("parser/".. lang.. ".*", false)
  return #found > 0
end

-- 3. Filter missing languages
local to_install = {}
for _, lang in ipairs(ensure_list) do
  if not is_installed(lang) then
    table.insert(to_install, lang)
  end
end

-- 4. Install missing parsers
if #to_install > 0 then
  -- Schedule installation to avoid blocking startup
  vim.schedule(function()
    vim.notify("Installing Tree-sitter parsers: ".. table.concat(to_install, ", "), vim.log.levels.INFO)
    ts.install(to_install)
  end)
end

-- 5. Enable Native Highlighting
--    nvim-treesitter 'main' no longer handles 'highlight = { enable = true }'.
--    We must start the native engine manually on FileType.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NativeTreesitter", { clear = true }),
  callback = function(args)
    -- silent pcall to avoid errors if no parser exists for the filetype
    pcall(vim.treesitter.start, args.buf)
  end,
})
