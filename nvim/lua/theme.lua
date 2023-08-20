--[[theme.lua
-- Theme configuration, such as colorscheme etc.
--]]

-- Transparency

vim.g.transparent_enabled = true

-- Colorscheme --

vim.cmd [[
try
  colorscheme tokyonight
catch
  colorscheme default
endtry
]]

-- Brighten line numbers for Tokyonight

local colors = require("tokyonight.colors")
if vim.g.colors_name == 'tokyonight' then
  -- Set bright colors for line numbers
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = "#FFFFFF" })
  vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = colors.default.dark5 })
  vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = colors.default.dark5 })

  -- Set bright colors for Comments
  vim.api.nvim_set_hl(0, 'Comment', { fg = colors.default.dark5, italic = true })
end
