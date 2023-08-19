--[[theme.lua
-- Theme configuration, such as colorscheme etc.
--]]

-- Transparency

vim.g.transparent_enabled = true

-- Colorscheme --

vim.cmd [[
try
  colorscheme tokyonight-moon
catch
  colorscheme default
endtry
]]

-- Brighten line numbers

local colors = require("tokyonight.colors")

vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = "#FFFFFF" })
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = colors.default.dark5 })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = colors.default.dark5 })
