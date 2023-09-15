--[[theme.lua
-- Theme configuration, such as colorscheme etc.
--]]

-- Transparency

vim.g.transparent_enabled = true

-- Colorscheme --

vim.cmd([[
try
  colorscheme tokyonight-moon
catch
  colorscheme default
endtry
]])

-- Brighten line numbers for Tokyonight

local colors = require("tokyonight.colors")
if vim.g.colors_name == "tokyonight" then
	-- Set bright colors for line numbers
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFFFF" })
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.default.dark5 })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.default.dark5 })

	-- Set bright colors for Comments
	vim.api.nvim_set_hl(0, "Comment", { fg = colors.default.dark5, italic = true })
end

-- Notify config

---@diagnostic disable-next-line: missing-fields
require("notify").setup({
	-- Animation style
	stages = "static",
	-- Render style for notifications
	render = "compact",
})

-- Noice config for messages, cmdline, and popupmenu

require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		throttle = 1000 / 5,
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = true, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
	cmdline = {
		view = "cmdline",
	},
	messages = {
		enabled = false,
	},
})
