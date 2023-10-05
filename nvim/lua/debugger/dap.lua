--[[ dap.lua
-- This file configures the DAP family of plugins
--]]

-- DAP UI opn/close automatically

local dap, dapui = require("dap"), require("dapui")

-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Adapter configurations

-- Load vscode launch.json configs
require("dap.ext.vscode").load_launchjs(".vscode/launch.json", {
	chrome = { "typescript", "javascript", "typescriptreact" },
	codelldb = { "c", "cpp", "rust" },
	cppdbg = { "c", "cpp" },
	ocamlearlybird = { "ocaml" },
})

local mason = require("mason-registry")

local chrome_dbg_adapter = mason.get_package("chrome-debug-adapter")
local chrome_dbg_adapter_path = chrome_dbg_adapter.get_install_path(chrome_dbg_adapter)

dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = {
		chrome_dbg_adapter_path .. "/out/src/chromeDebug.js",
	},
}

-- INFO: see https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)

local codelldb_adapter = mason.get_package("codelldb")
local codelldb_adapter_path = chrome_dbg_adapter.get_install_path(codelldb_adapter)

dap.adapters.codelldb = {
	type = "server",
	port = "13000",
	executable = {
		command = codelldb_adapter_path .. "/extension/adapter/codelldb",
		args = { "--port", "13000" },
	},
	name = "codelldb",
}

local cpptools_adapter = mason.get_package("cpptools")
local cpptools_adapter_path = cpptools_adapter.get_install_path(cpptools_adapter)

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = cpptools_adapter_path .. "/extension/debugAdapters/bin/OpenDebugAD7",
}

dap.adapters.rust = {
	id = "cppdbg",
	type = "executable",
	command = cpptools_adapter_path .. "/extension/debugAdapters/bin/OpenDebugAD7",
}

-- TODO: fix ocaml debugger / doesn't work

-- -- dap.adapters.ocamlearlybird = {
-- -- 	type = "executable",
-- -- 	command = "node",
-- -- 	args = { vim.fn.expand("$HOME/work/ocamlearlybird/integrations/vscode/extension.js") },
-- -- }

-- UI Configuration

M.config = function()
	lvim.builtin.dap = {
		active = true,
		on_config_done = nil,
		breakpoint = {
			text = lvim.icons.ui.Bug,
			texthl = "DiagnosticSignError",
			linehl = "",
			numhl = "",
		},
		breakpoint_rejected = {
			text = lvim.icons.ui.Bug,
			texthl = "DiagnosticSignError",
			linehl = "",
			numhl = "",
		},
		stopped = {
			text = lvim.icons.ui.BoldArrowRight,
			texthl = "DiagnosticSignWarn",
			linehl = "Visual",
			numhl = "DiagnosticSignWarn",
		},
		log = {
			level = "info",
		},
		ui = {
			auto_open = true,
			notify = {
				threshold = vim.log.levels.INFO,
			},
			config = {
				icons = { expanded = "", collapsed = "", circular = "" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				-- Use this to override mappings for specific elements
				element_mappings = {},
				expand_lines = true,
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.33 },
							{ id = "breakpoints", size = 0.17 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 0.33,
						position = "right",
					},
					{
						elements = {
							{ id = "repl", size = 0.45 },
							{ id = "console", size = 0.55 },
						},
						size = 0.27,
						position = "bottom",
					},
				},
				controls = {
					enabled = true,
					-- Display controls in this element
					element = "repl",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "",
						terminate = "",
					},
				},
				floating = {
					max_height = 0.9,
					max_width = 0.5, -- Floats will be treated as percentage of your screen.
					border = "rounded",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil, -- Can be integer or nil.
					max_value_lines = 100, -- Can be integer or nil.
				},
			},
		},
	}
end

M.setup = function()
	local status_ok, dap = pcall(require, "dap")
	if not status_ok then
		return
	end

	if lvim.use_icons then
		vim.fn.sign_define("DapBreakpoint", lvim.builtin.dap.breakpoint)
		vim.fn.sign_define("DapBreakpointRejected", lvim.builtin.dap.breakpoint_rejected)
		vim.fn.sign_define("DapStopped", lvim.builtin.dap.stopped)
	end

	dap.set_log_level(lvim.builtin.dap.log.level)

	if lvim.builtin.dap.on_config_done then
		lvim.builtin.dap.on_config_done(dap)
	end
end

M.setup_ui = function()
	local status_ok, dap = pcall(require, "dap")
	if not status_ok then
		return
	end
	local dapui = require("dapui")
	dapui.setup(lvim.builtin.dap.ui.config)

	if lvim.builtin.dap.ui.auto_open then
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		-- dap.listeners.before.event_terminated["dapui_config"] = function()
		--   dapui.close()
		-- end
		-- dap.listeners.before.event_exited["dapui_config"] = function()
		--   dapui.close()
		-- end
	end

	-- until rcarriga/nvim-dap-ui#164 is fixed
	local function notify_handler(msg, level, opts)
		if level >= lvim.builtin.dap.ui.notify.threshold then
			return vim.notify(msg, level, opts)
		end

		opts = vim.tbl_extend("keep", opts or {}, {
			title = "dap-ui",
			icon = "",
			on_open = function(win)
				vim.api.nvim_buf_set_option(vim.api.nvim_win_get_buf(win), "filetype", "markdown")
			end,
		})

		-- vim_log_level can be omitted
		if level == nil then
		elseif type(level) == "string" then
		else
			-- https://github.com/neovim/neovim/blob/685cf398130c61c158401b992a1893c2405cd7d2/runtime/lua/vim/lsp/log.lua#L5
			level = level + 1
		end

		msg = string.format("%s: %s", opts.title, msg)
	end

	local dapui_ok, _ = xpcall(function()
		require("dapui.util").notify = notify_handler
	end, debug.traceback)
	if not dapui_ok then
		Log:debug("Unable to override dap-ui logging level")
	end
end
