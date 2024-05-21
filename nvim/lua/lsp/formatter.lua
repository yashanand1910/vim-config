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
		python = { "black", "isort" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		cuda = { "clang_format" },
		tex = { "latexindent" },
		ocaml = { "ocamlformat" },
		go = { "gofumpt" },
		cmake = { "cmake_format" },
	},
})
