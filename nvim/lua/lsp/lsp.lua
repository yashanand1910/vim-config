--[[ lsp.lua
-- Configuration for Neovim's built-in LSP
--]]
local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end
local mason_lspconfig = require("mason-lspconfig")

--[[ set_diagnostics_config()
-- Initialize Vim diagnostics settings
--]]
---@diagnostic disable-next-line: unused-local, unused-function
local function set_diagnostics_config()
	vim.diagnostic.config({
		float = {
			border = "rounded",
			format = function(diagnostic)
				-- "ERROR (line n): message"
				return string.format(
					"%s (line %i): %s",
					vim.diagnostic.severity[diagnostic.severity],
					diagnostic.lnum,
					diagnostic.message
				)
			end,
		},
	})
end

-- List of LSP servers used later
-- Always check the memory usage of each language server. :LSpInfo to identify LSP server
-- and use "sudo lsof -p PID" to check for associated files
local server_list = {
	"bashls",
	"clangd",
	"lua_ls",
	-- "pylsp",
	-- "texlab",
	"jsonls",
	"tsserver",
	"angularls",
	"eslint",
	-- "ocamllsp",
	"gopls",
}

-- nvim_cmp capabilities
local cmp_capability = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Let Mason-lspconfig handle LSP setup
mason_lspconfig.setup({
	ensure_installed = server_list,
	automatic_installation = true,
})

mason_lspconfig.setup_handlers({
	-- Default handler
	function(server_name)
		lspconfig[server_name].setup({ capabilities = cmp_capability, on_attach = on_attach })
	end,
	["clangd"] = function()
		lspconfig.clangd.setup({
			capabilities = cmp_capability,
			on_attach = on_attach,
			cmd = { "clangd", "--background-index" },
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			init_options = {
				clangdFileStatus = true,
				usePlaceholders = true,
				completeUnimported = true,
				semanticHighlighting = true,
			},
		})
	end,
	-- Lua gets a special treatment
	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			capabilities = cmp_capability,
			on_attach = on_attach,
			settings = {
				-- https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/lua.template.editorconfig
				Lua = {
					format = {
						enable = true,
					},
					diagnostics = {
						globals = { "vim", "on_attach" }, --> Make diagnostics tolerate vim.fun.stuff
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("lua", true), --> Expose some Neovim API
						checkThirdParty = false, --> Disable third party library check
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
})
-- }}}

-- NOTE: Workaround for clangd encoding issue (see https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
require("lspconfig").clangd.setup({ capabilities = capabilities })
