-- Vim Options
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.clipboard = ""
vim.opt.mouse = ""

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.transparent_window = true
lvim.colorscheme = "lunar"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

vim.g.python3_host_prog = "/Users/yashanand/.pyenv/versions/neovim/bin/python"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- trouble
lvim.builtin.which_key.mappings["l"]["t"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble (Document)" }
lvim.builtin.which_key.mappings["l"]["T"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble (Workspace)" }
lvim.builtin.which_key.mappings["r"] = { "<cmd>Telescope live_grep<cr>", "Live grep" }
-- diffview
lvim.builtin.which_key.mappings["g"]["DD"] = { "<cmd>DiffviewOpen<cr>", "Diffview Open" }
lvim.builtin.which_key.mappings["g"]["DQ"] = { "<cmd>DiffviewClose<cr>", "Diffview Open" }
-- todo-comments
lvim.builtin.which_key.mappings["l"]["x"] = {
	l = { "<cmd>TodoTrouble<cr>", "TODOs" },
	j = {
		function()
			require("todo-comments").jump_next()
		end,
		"Jump next (TODOs)",
	},
	k = {
		function()
			require("todo-comments").jump_prev()
		end,
		"Jump prev (TODOs)",
	},
}

-- vimux
lvim.builtin.which_key.mappings["v"] = {
	name = "Vimux",
	n = { "<cmd>VimuxPromptCommand<cr>", "New command" },
	c = { "<cmd>VimuxClearTerminalScreen<cr>", "Clear" },
	i = { "<cmd>VimuxInspectRunner<cr>", "Inspect" },
	v = { "<cmd>VimuxRunLastCommand<cr>", "Last command" },
}
-- vim-test
lvim.builtin.which_key.mappings["t"] = {
	name = "Test",
	t = { "<cmd>TestNearest<cr>", "Test nearest" },
	c = { "<cmd>TestClass<cr>", "Test class" },
	f = { "<cmd>TestFile<cr>", "Test file" },
	a = { "<cmd>TestSuite<cr>", "Test suite" },
}
-- Octo (GitHub)
lvim.builtin.which_key.mappings["o"] = {
	name = "Octo (GitHub)",
	a = { "<cmd>Octo actions<cr>", "Actions" },
	s = { "<cmd>Octo search<cr>", "Search" },
	pl = { "<cmd>Octo pr list<cr>", "PR list" },
	pa = { "<cmd>Octo pr create<cr>", "PR create" },
	px = { "<cmd>Octo pr changes<cr>", "PR changes" },
	pc = { "<cmd>Octo pr checks<cr>", "PR checks" },
	pp = { "<cmd>Octo pr checkout<cr>", "PR checkout" },
	pM = { "<cmd>Octo pr merge<cr>", "PR merge" },
	pC = { "<cmd>Octo pr close<cr>", "PR close" },
	rs = { "<cmd>Octo review start<cr>", "Start review" },
	rx = { "<cmd>Octo review close<cr>", "Close review" },
	rS = { "<cmd>Octo review submit<cr>", "Submit review" },
	rr = { "<cmd>Octo review resume<cr>", "Resume review" },
	rd = { "<cmd>Octo review discard<cr>", "Discard review" },
	rC = { "<cmd>Octo review comments<cr>", "View pending review comments" },
	rc = { "<cmd>Octo review commit<cr>", "Pick commit to review" },
}
-- ChatGPT
lvim.builtin.which_key.mappings["C"] = {
	name = "ChatGPT",
	C = { "<cmd>ChatGPT<cr>", "Open" },
	a = { "<cmd>ChatGPTActAs<cr>", "Open as" },
	e = { "<cmd>ChatGPTEditWithInstructions<cr>", "Open with edit instructions" },
}
-- fugitive (git)
lvim.builtin.which_key.mappings["G"] = {
	name = "Fugitive",
	w = { "<cmd>Gwrite<cr>", "Write" },
	f = { "<cmd>G fetch<cr>", "Fetch" },
	a = { "<cmd>G add %<cr>", "Add" },
	A = { "<cmd>G add .<cr>", "Add all" },
	cc = { "<cmd>G commit<cr>", "Commit" },
	CC = { "<cmd>G add . | G commit -c HEAD<cr>", "Commit all (prev msg)" },
	CN = { "<cmd>G add . | G commit<cr>", "Commit all" },
	s = { "<cmd>G<cr>", "Status" },
	l = { "<cmd>G blame<cr>", "Blame" },
	L = { "<cmd>Gclog<cr>", "Log" },
	B = { "<cmd>GBrowse<cr>", "Browse" },
	p = { "<cmd>G -c pull.default=current pull<cr>", "Pull" },
	P = { "<cmd>G -c push.default=current push<cr>", "Push" },
}
-- other
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv" -- move line down in visual mode
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv" -- move line up in visual mode
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz" -- scroll half page down and recenter
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz" -- scroll half page up and recenter
lvim.keys.insert_mode["<C-a>"] = "<C-o>A" -- 'A' when in insert mode
lvim.builtin.which_key.mappings["R"] = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Swap current word" }
lvim.builtin.which_key.mappings["Q"] = { "<cmd>quitall<cr>", "Quit all" }
lvim.builtin.which_key.mappings["W"] = { "<cmd>wall<cr>", "Save all" }
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,vim
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"tsx",
	"css",
	"rust",
	"java",
	"yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "horizontal"

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
	return server ~= "angularls"
end, lvim.lsp.automatic_configuration.skipped_servers)

require("lvim.lsp.manager").setup("eslint") -- Workaround: because null-ls eslint is pretty bad
require("lvim.lsp.manager").setup("jedi_language_server")
require("lvim.lsp.manager").setup("emmet_ls")

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		command = "nginx_beautifier",
	},
	{
		command = "xmlformat",
	},
	{
		command = "prettier",
	},
	{
		command = "black",
	},
	{
		command = "stylua",
	},
	{
		command = "latexindent",
	},
	-- {
	--   command = "ocamlformat"
	-- }
})
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		command = "actionlint",
	},
	{
		command = "stylelint",
	},
	{
		command = "vale",
	},
	{
		command = "pylint",
	},
	{
		command = "commitlint",
	},
})

-- set code actions
-- local actions = require("lvim.lsp.null-ls.code_actions")
-- actions.setup({
-- 	{
-- 		command = "refactoring",
-- 	}
-- })
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
	-- themes
	{
		"ray-x/starry.nvim",
		enabled = false,
		config = function()
			vim.g.starry_italic_comments = true
		end,
	},
	{
		"wuelnerdotexe/vim-enfocado",
		config = function()
			vim.g["enfocado_style"] = "neon"
		end,
	},
	"Yazeed1s/minimal.nvim",
	{
		"projekt0n/github-nvim-theme",
		version = "v0.0.7",
	},
	{
		"kartikp10/noctis.nvim",
		dependencies = { "rktjmp/lush.nvim" },
	},
	"arzg/vim-colors-xcode",
	{
		"olivercederborg/poimandres.nvim",
		config = function()
			require("poimandres").setup({
				-- leave this setup function empty for default config
				-- or refer to the configuration section
				-- for configuration options
			})
		end,
	},
	"Yazeed1s/oh-lucy.nvim",
	"tiagovla/tokyodark.nvim",
	"Mofiqul/dracula.nvim",

	-- other plugins
	-- TODO: fix conflicting hotkeys for completion
	"github/copilot.vim",
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{ "zbirenbaum/copilot-cmp", after = { "copilot.lua", "nvim-cmp" } },
	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				highlight = {
					pattern = [[.*<(KEYWORDS)\s*]],
				},
			})
		end,
	},
	{
		"ruifm/gitlinker.nvim",
		config = function()
			require("gitlinker").setup()
		end,
		dependencies = "nvim-lua/plenary.nvim",
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	{
		"vim-test/vim-test",
		config = function()
			vim.g["test#strategy"] = "toggleterm"
			-- vim.g["test#neovim#term_position"] = "right 25"
			-- vim.g["test#preserve_screen"] = 0
		end,
	},
	{
		"preservim/vimux",
		config = function()
			vim.g["VimuxHeight"] = "30"
			vim.g["VimuxOrientation"] = "h"
		end,
	},
	"mattn/emmet-vim",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{
		"lervag/vimtex", -- TODO: fix plugin not loading
		lazy = false,
		config = function()
			vim.g["tex_flavor"] = "latex"
			vim.g["vimtex_compiler_method"] = "latexmk"
			vim.g["vimtex_view_method"] = "skim"
			vim.g["vimtex_view_skim_sync"] = 1
			vim.g["vimtex_view_skim_activate"] = 1
		end,
	},
	{
		"pwntester/octo.nvim", -- TODO fix omni-completion and fix add comment in PR review
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			-- "kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	},
	{
		"petertriho/cmp-git",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			table.insert(lvim.builtin.cmp.sources, {
				name = "git",
			})
			require("cmp_git").setup()
		end,
	},
	"editorconfig/editorconfig-vim",
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{
		"tiagovla/scope.nvim",
		config = function()
			require("scope").setup()
		end,
	},
	-- { "nvim-treesitter/nvim-treesitter-angular" },
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		dependencies = "hrsh7th/nvim-cmp",
		event = "InsertEnter",
		opts = {
			show_prediction_strength = true, -- TODO: fix / not working
		},
	},
	{
		"onsails/lspkind.nvim",
		init = function()
			-- Override CMP formatter (which is set by LVIM)
			local lspkind = require("lspkind")
			local source_names = lvim.builtin.cmp.formatting.source_names
			lvim.builtin.cmp.formatting.max_width = 80
			lvim.builtin.cmp.formatting.format = function(entry, vim_item)
				-- if you have lspkind installed, you can use it like
				-- in the following line:
				vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol_text" })
				vim_item.menu = source_names[entry.source.name]
				if lvim.use_icons then
					if entry.source.name == "copilot" then
						vim_item.kind_hl_group = "CmpItemKindCopilot"
					end

					if entry.source.name == "cmp_tabnine" then
						vim_item.kind_hl_group = "CmpItemKindTabnine"
						local detail = (entry.completion_item.data or {}).detail
						vim_item.kind = ""
						if detail and detail:find(".*%%.*") then
							vim_item.kind = vim_item.kind .. " " .. detail
						end

						if (entry.completion_item.data or {}).multiline then
							vim_item.kind = vim_item.kind .. " " .. "[ML]"
						end
					end

					if entry.source.name == "crates" then
						vim_item.kind_hl_group = "CmpItemKindCrate"
					end

					if entry.source.name == "lab.quick_data" then
						vim_item.kind_hl_group = "CmpItemKindConstant"
					end

					if entry.source.name == "emoji" then
						vim_item.kind_hl_group = "CmpItemKindEmoji"
					end
				end
				local max_width = lvim.builtin.cmp.formatting.max_width
				vim_item.abbr = string.sub(vim_item.abbr, 1, max_width)
				return vim_item
			end
		end,
	},
	{ "aymericbeaumet/vim-symlink", dependencies = { "moll/vim-bbye" } },
	"tpope/vim-surround",
	"ocaml/vim-ocaml",
}

-- Can not be placed into the config method of the plugins.
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

-- TODO: fix / notworking (mason_registry.get_package)

-- DAP config
-- local dap = require("dap")
-- local mason_registry = require("mason-registry")

-- dap.adapters.chrome = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = {
-- 		mason_registry.get_package("chrome-debug-adapter"):get_install_path() .. "/out/src/chromeDebug.js",
-- 	},
-- }

-- -- INFO: see https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)

-- dap.adapters.codelldb = {
-- 	type = "server",
-- 	port = "13000",
-- 	executable = {
-- 		command = lvim.builtin.mason.install_root_dir .. "/packages/codelldb" .. "/extension/adapter/codelldb",
-- 		args = { "--port", "13000" },
-- 	},
-- 	name = "codelldb",
-- }

-- dap.adapters.cppdbg = {
-- 	id = "cppdbg",
-- 	type = "executable",
-- 	command = mason_registry.get_package("cpptools"):get_install_path() .. "/extension/debugAdapters/bin/OpenDebugAD7",
-- }

-- -- TODO: fix / doesn't work

-- dap.adapters.ocamlearlybird = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { vim.fn.expand("$HOME/work/ocamlearlybird/integrations/vscode/extension.js") },
-- }

require("dap.ext.vscode").load_launchjs(".dap/launch.json", {
	chrome = { "typescript", "javascript" },
	codelldb = { "c", "cpp", "rust" },
	cppdbg = { "c", "cpp" },
	ocamlearlybird = { "ocaml" },
})

-- Fix filetype detection for ocamllex files
-- WARN: Workaround for until this gets merged https://github.com/ocaml/vim-ocaml/pull/61

vim.api.nvim_create_autocmd("BufEnter,BufRead", {
	pattern = "*.mll",
	callback = function()
		vim.opt_local.filetype = "ocamllex"
		local clang_client = vim.lsp.get_active_clients({ "ocamllsp" })
		vim.lsp.stop_client(clang_client, true)
		vim.diagnostic.disable()
		vim.diagnostic.reset()
	end,
})
-- Fix filetype detection for ocamlyacc files
vim.api.nvim_create_autocmd("BufEnter,BufRead", {
	pattern = "*.mly",
	callback = function()
		vim.opt_local.filetype = "menhir"
		vim.diagnostic.disable()
		vim.diagnostic.reset()
	end,
})

-- TODO : temporary for c0 programs (CMU compiler design)

vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*.l[1-6]",
	callback = function()
		vim.opt_local.filetype = "c"
		vim.diagnostic.disable()
		vim.diagnostic.reset()
	end,
})
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   -- change directory based on buffer
--   command = "silent! lcd %:p:h",
-- })
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
