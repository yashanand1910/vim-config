--[[ init.lua
-- Initialize all configuration files
--]]

-- Try catch for modules
local function safe_require(module)
  local status, loaded_module = pcall(require, module)
  if status then
    return loaded_module
  end
  vim.notify("Error loading the module: " .. module)
  return nil
end

-- UI elements
local highlights = safe_require("ui.highlights")
if highlights then highlights.setup() end
local statusline = safe_require("ui.statusline")
if statusline then statusline.setup() end
local tabline = safe_require("ui.tabline")
if tabline then tabline.setup() end

-- Core config modules
safe_require("core")
safe_require("plugins")
safe_require("keybinds")

-- Theme config modules
safe_require("theme")

-- LSP configurations
safe_require("lsp.lsp")
safe_require("lsp.completion")

-- Debugger configurations
safe_require("debugger.dap")

-- Plugin configurations
safe_require("config.treesitter")

-- Miscellaneous configurations
safe_require("misc")
