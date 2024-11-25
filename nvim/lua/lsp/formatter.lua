--[[ formatter.lua
-- Configuration for formatter
--]]

local formatter = require("conform")

formatter.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		yaml = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		html = { "prettier" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		python = { "blue", "isort" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		cuda = { "clang_format" },
		tex = { "latexindent" },
		ocaml = { "ocamlformat" },
		go = { "gofumpt", "golines" },
		cmake = { "cmake_format" },
		zsh = { "beautysh" },
		sh = { "beautysh" },
		bash = { "beautysh" },
		markdown = { "prettier", "cbfmt" },
    css = { "prettier" },
    scss = { "prettier" },
	},
})
