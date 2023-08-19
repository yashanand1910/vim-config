--[[theme.lua
-- Theme configuration, such as colorscheme etc.
--]]

-- Colorscheme --

vim.cmd [[
try
  colorscheme tokyonight
catch
  colorscheme default
endtry
]]

vim.g.transparent_enabled = true
