--[[ highlights.lu
-- Initialize highlights used by UI modules
--]]
local M = {}

--[[ create_highlights_nvim_api()
-- Create highlights using
--
-- @arg group String for the highlight group, i.e. "name" of the highlight
-- @arg properties Lua table containing fg, bg, font information
--]]
local create_highlight_nvim_api = function(group, properties)
	vim.api.nvim_set_hl(0, group, properties)
end

--[[ create_highlight_vimscript()
-- Creates a new highlight group using Vimscript. Suitable for groups with foreground or background only
-- it is slower compared to create_highlights_nvim_api
--   https://www.reddit.com/r/neovim/comments/sihuq7/comment/hvazzwp/?utm_source=share&utm_medium=web2x&context=3
--
-- @arg group: Name of the highlight group to create
-- @arg fg: Foreground hex code. If none is provided, nil is used
-- @arg bg: Background hex code. If none is provided, nil is used
--]]
local create_highlight_vimscript = function(group, fg, bg)
	local highlight_cmd = "highlight " .. group
	highlight_cmd = (fg ~= nil) and (highlight_cmd .. " guifg=" .. fg) or highlight_cmd
	highlight_cmd = (bg ~= nil) and (highlight_cmd .. " guibg=" .. bg) or highlight_cmd
	vim.cmd(highlight_cmd)
end

--[[ get_hl_component()
-- Wrapper around nvim_get_hl() to extract the value of specified attribute
--
-- @arg name Name of the highlight group
-- @arg attribute Attribute user wants to know the value of
--]]
local function get_hl_component_nvim_api(name, attribute)
	local group = vim.api.nvim_get_hl(0, { name = name })
	return group[attribute]
end

--[[ get_hl_component_vimscript()
-- Extract a specific highlight value using Vimscript function
-- This is worse version of get_hl_component_nvim_api()
-- If you are using Neovim >= 0.9, use vim.api.nvim_get_hl() like in get_hl_component_nvim_api()
--
-- @arg name Name of the highlight group
-- @arg attribute Attribute user wants to know the value of
--]]
local function get_hl_component_vimscript(name, attribute)
	local fn = vim.fn
	return fn.synIDattr(fn.synIDtrans(fn.hlID(name)), attribute)
end

--[[
-- Table containing all the highlights to be initialized
--]]
M.highlights = {
	-- Invert current tabline color for cleaner look
	TabLineSel = {
		-- For Neovim 0.8 compatibility as of V.2023.08.17, we cannot use vim.api.nvim_get_hl()
		fg = get_hl_component_vimscript("TabLineSel", "bg"),
		bg = get_hl_component_vimscript("TabLineSel", "fg"),
		italic = true,
	},

	-- Custom highlights (from my old colorscheme [Pastelcula](https://github.com/theopn/pastelcula.nvim) )
	PastelculaBlueAccent = { fg = "#5AB0F6" },
	PastelculaRedAccent = { fg = "#FAA5A5" },
	PastelculaGreenAccent = { fg = "#BDF7AD" },
	PastelculaYellowAccent = { fg = "#F3FFC2" },
	PastelculaPurpleAccent = { fg = "#D3B3F5" },
	PastelculaOrangeAccent = { fg = "#FFCAA1" },
	PastelculaLightGreyAccent = { fg = "#B7C2C7", italic = true },
	PastelculaGreyAccent = { fg = "#828B8F" },
}

--[[ setup()
-- using M.highlights and preferred create_highlight function, create highlights
--]]
M.setup = function()
	for group, properties in pairs(M.highlights) do
		create_highlight_nvim_api(group, properties)
	end
end

return M
