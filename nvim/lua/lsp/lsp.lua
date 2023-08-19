--[[ lsp.lua
-- Configuration for Neovim's built-in LSP
--]]
local status, lspconfig = pcall(require, "lspconfig")
if (not status) then return end
local mason_lspconfig = require("mason-lspconfig")

--[[ set_diagnostics_config()
-- Initialize Vim diagnostics settings
--]]
local function set_diagnostics_config()
  vim.diagnostic.config({
    float = {
      border = "rounded",
      format = function(diagnostic)
        -- "ERROR (line n): message"
        return string.format("%s (line %i): %s",
          vim.diagnostic.severity[diagnostic.severity],
          diagnostic.lnum,
          diagnostic.message)
      end
    },
  })
end

--[[ on_attach()
-- A function to attach for a buffer with LSP capabilities
-- List of features:
--   - Provide a "LinterToggle" user command
--   - If conditions are met, format the buffer before write
--
-- @arg client: name of the client name used by Neovim
-- @arg bufnr: buffer number used by Neovim
--]]
-- local on_attach = function(client, bufnr)
--   -- Basic settings
--   set_diagnostics_config()
--   -- Global var for auto formatting toggle
--   if not vim.g.linter_status then vim.g.linter_status = true end
--   if client.server_capabilities.documentFormattingProvider then
--     -- User command to toggle code format only available when LSP is detected
--     vim.api.nvim_create_user_command("LspLinterToggle", function()
--         vim.g.linter_status = not vim.g.linter_status
--         print(string.format("Linter %s!", (vim.g.linter_status) and ("on!") or ("off!")))
--       end,
--       { nargs = 0 })
--
--     -- Autocmd for code formatting on the write
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       group = vim.api.nvim_create_augroup("Format", { clear = false }),
--       buffer = bufnr,
--       callback = function()
--         if vim.g.linter_status then vim.lsp.buf.format() end
--       end
--     })
--   end
-- end

-- List of LSP server used later
-- Always check the memory usage of each language server. :LSpInfo to identify LSP server
-- and use "sudo lsof -p PID" to check for associated files
local server_list = {
  "bashls", "clangd", "lua_ls", "pylsp", "texlab",
}

-- nvim_cmp capabilities
local cmp_capability = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Let Mason-lspconfig handle LSP setup
mason_lspconfig.setup {
  ensure_installed = server_list,
  automatic_installation = true,
}

mason_lspconfig.setup_handlers({
  -- Default handler
  function(server_name)
    lspconfig[server_name].setup({ capabilities = cmp_capability, on_attach = on_attach, })
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
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
            },
          },
          diagnostics = {
            globals = { "vim", "on_attach" } --> Make diagnostics tolerate vim.fun.stuff
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("lua", true), --> Expose some Neovim API
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
