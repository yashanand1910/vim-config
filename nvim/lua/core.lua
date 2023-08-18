--[[core.lua
-- Core configuration for nvim, written only using stock Neovim features and Lua without external plugins or moduels
-- This file alone should provide a sane default Neovim experience (you can rename it as init.lua to use it standalone)
--]]
local opt = vim.opt

--------------------------------------------------------- OPT: ---------------------------------------------------------

do
  local base_opt = {
    { "filetype",      "on" }, --> Detect the type of the file that is edited
    { "syntax",        "on" }, --> Turn the default highlighting on, overriden by Treesitter in supported buffers
    { "confirm",       true }, --> Confirm before exiting with unsaved bufffer(s)
    { "autochdir",     false }, --> When on, Vim will change the CWD whenever you open a file, switch buffers ,etc.
    { "scrolloff",     7 }, --> Keep minimum x number of screen lines above and below the cursor
    { "showtabline",   2 }, --> 0: never, 1: if there are at least two tab pages, 2: always
    { "laststatus",    3 }, --> Similar to showtabline, and in Nvim 0.7, 3 displays one bar for multiple windows
    -- Search --
    { "hlsearch",      true }, --> Highlight search results
    { "incsearch",     true }, --> As you type, match the currently typed workd w/o pressing enter
    { "ignorecase",    true }, --> Ignore case in search
    { "smartcase",     true }, --> /smartcase -> apply ignorecase | /sMartcase -> do not apply ignorecase
    -- Split pane --
    { "splitright",    true }, --> Vertical split created right
    { "splitbelow",    true }, --> Horizontal split created below
    { "termguicolors", true }, --> Enables 24-bit RGB color in the TUI
    { "mouse",         "" }, --> Enable mouse
    { "guicursor",     "" }, --> Reset default cursor
    { "list",          true }, --> Needed for listchars
    { "listchars", --> Listing special chars
      { tab = "⇥ ", leadmultispace = "│ ", trail = "␣", nbsp = "⍽" } },
    { "showbreak", "↪" }, --> Beginning of wrapped lines
    -- Fold --
    { "foldmethod", "expr" }, --> Leave the fold up to treesitter
    { "foldlevel", 1 }, --> Ignored when expr, but when folding by "marker", it only folds folds w/in a fold only
    { "foldenable", false }, --> True for "marker" + level = 1, false for TS folding
  }
  -- Folding using TreeSitter --
  opt.foldexpr = "nvim_treesitter#foldexpr()"
  for _, v in ipairs(base_opt) do
    opt[v[1]] = v[2]
  end
end

do
  local edit_opt = {
    { "tabstop",      2 },      --> How many characters Vim /treats/renders/ <TAB> as
    { "softtabstop",  0 },      --> How many chracters the /cursor/ moves with <TAB> and <BS> -- 0 to disable
    { "expandtab",    true },   --> Use space instead of tab
    { "shiftwidth",   2 },      --> Number of spaces to use for auto-indentation, <<, >>, etc.
    { "spelllang",    "en" },   --> Engrish
    { "spellsuggest", "best,8" }, --> Suggest 8 words for spell suggestion
    { "spell",        false },  --> autocmd will enable spellcheck in Tex or markdown
  }
  for _, v in ipairs(edit_opt) do
    opt[v[1]] = v[2]
  end
  -- Trimming extra whitespaces --
  -- \s: white space char, \+ :one or more, $: end of the line, e: suppresses warning, no need for <CR> for usercmd
  vim.api.nvim_create_user_command("TrimWhitespace", ":let save=@/<BAR>:%s/\\s\\+$//e<BAR>:let @/=save<BAR>",
    { nargs = 0 })
  -- Show the changes made since the last write
  vim.api.nvim_create_user_command("ShowChanges", ":w !diff % -",
    { nargs = 0 })
  -- Change curr window local dir to the dir of curr file
  vim.api.nvim_create_user_command("CD", ":lcd %:h",
    { nargs = 0 })
end

do
  local win_opt = {
    { "number",         true }, --> Line number
    { "relativenumber", true },
    { "numberwidth",    3 },  --> Width of the number
    { "cursorline",     true },
    { "cursorcolumn",   true },
  }
  for _, v in pairs(win_opt) do
    opt[v[1]] = v[2]
  end
end
-- }}}

------------------------------------------------------- AUTOCMD --------------------------------------------------------

-- {{{ File settings based on ft
-- Dictionary for supported file type (key) and the table containing values (values)
local ft_style_vals = {
  ["c"] = { colorcolumn = "80", tabwidth = 2 },
  ["cpp"] = { colorcolumn = "80", tabwidth = 2 },
  ["python"] = { colorcolumn = "80", tabwidth = 4 },
  ["java"] = { colorcolumn = "120", tabwidth = 4 },
  ["lua"] = { colorcolumn = "120", tabwidth = 2 },
}
-- Make an array of the supported file type
local ft_names = {}
local n = 0
for i, _ in pairs(ft_style_vals) do
  n = n + 1
  ft_names[n] = i
end
-- Using the array and dictionary, make autocmd for the supported ft
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FileSettings", { clear = true }),
  pattern = ft_names,
  callback = function()
    vim.opt_local.colorcolumn = ft_style_vals[vim.bo.filetype].colorcolumn
    vim.opt_local.shiftwidth = ft_style_vals[vim.bo.filetype].tabwidth
    vim.opt_local.tabstop = ft_style_vals[vim.bo.filetype].tabwidth
  end
})
-- }}}

-- {{{ Spell check in relevant buffer filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("SpellCheck", { clear = true }),
  pattern = { "markdown", "tex", "text" },
  callback = function() vim.opt_local.spell = true end
})
-- }}}

-- {{{ Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
  callback = function() vim.highlight.on_yank() end,
})
-- }}}

-- {{{ Terminal autocmd
-- Switch to insert mode when terminal is open
local term_augroup = vim.api.nvim_create_augroup("Terminal", { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  -- TermOpen: for when terminal is opened for the first time
  -- BufEnter: when you navigate to an existing terminal buffer
  group = term_augroup,
  pattern = "term://*", --> only applicable for "BufEnter", an ignored Lua table key when evaluating TermOpen
  callback = function() vim.cmd("startinsert") end
})

-- Automatically close terminal unless exit code isn't 0
vim.api.nvim_create_autocmd("TermClose", {
  group = term_augroup,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    else
      vim.notify_once("Error code detected in the current terminal job!")
    end
  end
})
-- }}}
