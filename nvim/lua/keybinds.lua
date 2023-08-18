--[[ keybinds.lua
-- All the keybindings, including whichkey bindings are defined here.
--]]

local keymap = vim.keymap;

-- Leader --
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { noremap = true }) --> Unbind space
vim.g.mapleader = " "                                            --> Space as the leader key

--[[ url_handler()
-- Find the URL in the current line and open it in a browser if possible
--]]
local function url_handler()
  -- <something>://<something that aren't >,;)>
  local url = string.match(vim.fn.getline("."), "[a-z]*://[^ >,;)]*")
  if url ~= nil then
    vim.cmd("silent exec '!open " .. url .. "'")
  else
    vim.notify("No URI found in the current line")
  end
end

-- {{{ Keybinding table
local key_opt = {
  -- Convenience --
  { 'i', "jk",        "<ESC>",              "[j]o[k]er: Better ESC" },
  { 'n', "<leader>a", "gg<S-v>G",           "[a]ll: select all" },
  { 'n', "gx",        url_handler,          "Open URL under the cursor using shell open command" },

  -- Search --
  { 'n', "n",         "nzz",                "Highlight next search and center the screen" },
  { 'n', "N",         "Nzz",                "Highlight prev search and center the screen" },
  { 'n', "<leader>/", "<CMD>let @/=''<CR>", "[/]: clear search" }, --> @/ is the macro for the last search

  -- Copy and paste --
  { 'x', "<leader>y", '"+y',                "[y]ank: yank to the system clipboard (+)" },
  {
    'n',
    "<leader>p",
    "<CMD>reg", --> will be overriden in Telescope config
    "[p]aste: choose from a register",
  },
  {
    'x',
    "<leader>p",
    '"_dP', --> First, [d]elete the selection and send content to _ void reg then [P]aste (b4 cursor unlike small p)
    "[p]aste: paste the current selection without overriding the reg",
  },

  -- Terminal --
  { 't', "<ESC>",     "<C-\\><C-n>",        "[ESC]: exit insert mode for the terminal" },
  {
    'n',
    "<leader>z",
    function() --> will be overriden in misc.lua terminal location picker
      vim.cmd("botright " .. math.ceil(vim.fn.winheight(0) * (1 / 3)) .. "sp | term")
    end,
    "[z]sh: Launch a terminal below",
  },

  -- Spell check --
  {
    'i',
    "<C-s>",
    "<C-g>u<ESC>[s1z=`]a<C-g>u",
    "[s]pell: fix nearest spelling error and put the cursor back",
  },
  {
    'n',
    "<C-s>",
    "z=",
    "[s]pell: toggle spell suggestion window for the word under the cursor",
  },
  {
    'n',
    "<leader>st",
    "<CMD>set spell!<CR>",
    "[s]pell [t]oggle: turn spell check on/off for the current buffer",
  },

  -- Buffer --
  {
    'n',
    "<leader>b",
    ":ls<CR>:b<SPACE>", --> will be overriden in Telescope config
    "[b]uffer: open the buffer list",
  },
  { 'n', "<leader>[", "<CMD>bprevious<CR>", "[[]: navigate to prev buffer" },
  { 'n', "<leader>]", "<CMD>bnext<CR>",     "[]]: navigate to next buffer" },
  {
    'n',
    "<leader>k",
    ":ls<CR>:echo '[nvim] Choose a buf to delete (blank: choose curr buf, RET: confirm, ESC: cancel)'<CR>:bdelete<SPACE>",
    "[k]ill : Choose a buffer to kill",
  },

  -- Window --
  {
    'n',
    "<leader>+",
    "<CMD>exe 'resize ' . (winheight(0) * 3/2)<CR>",
    "[+]: Increase the current window height by one-third",
  },
  {
    'n',
    "<leader>-",
    "<CMD>exe 'resize ' . (winheight(0) * 2/3)<CR>",
    "[-]: Decrease the current window height by one-third",
  },
  {
    'n',
    "<leader>>",
    function()
      local width = math.ceil(vim.api.nvim_win_get_width(0) * 3 / 2)
      vim.cmd("vertical resize " .. width)
    end,
    "[>]: Increase the current window width by one-third",
  },
  {
    'n',
    "<leader><",
    function()
      local width = math.ceil(vim.api.nvim_win_get_width(0) * 2 / 3)
      vim.cmd("vertical resize " .. width)
    end,
    "[<]: Decrease the current window width by one-third",
  },

  -- Tab --
  {
    'n',
    "<leader>t",
    ":ls<CR>:echo '[nvim] Choose a buf to create a new tab w/ (blank: choose curr buf, RET: confirm, ESC: cancel)'<CR>:tab sb<SPACE>",
    "[t]ab: create a new tab",
  },
  { 'n',
    "<leader>q",
    "<CMD>tabclose<CR>",
    "[q]uit: close current tab",
  },
  { 'n', "<leader>1", "1gt", }, --> Go to 1st tab
  { 'n', "<leader>2", "2gt", },
  { 'n', "<leader>3", "3gt", },
  { 'n', "<leader>4", "4gt", },
  { 'n', "<leader>5", "5gt", },

  -- LSP --
  {
    'n',
    "<leader>ca",
    function() vim.notify_once("This keybinding requires lsp.lua module") end,
    "[c]ode [a]ction: open the menu to perform LSP features",
  },
}
-- }}}

-- Set keybindings
for _, v in ipairs(key_opt) do
  -- non-recursive mapping, call commands silently
  local opts = { noremap = true, silent = true }
  -- Add optional description to the table if provided
  if v[4] then opts.desc = v[4] end
  -- Set keybinding
  keymap.set(v[1], v[2], v[3], opts)
end
