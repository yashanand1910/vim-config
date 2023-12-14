--[[ formatter.lua
-- Configuration for formatter
--]]

local formatter = require("conform")

formatter.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		json = { "prettier" },
		html = { "prettier" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		python = {
			formatters = { "isort", "black" },
			run_all_formatters = true,
		},
		c = { "clang_format" },
		cpp = { "clang_format" },
		tex = { "latexindent" },
	},
})
