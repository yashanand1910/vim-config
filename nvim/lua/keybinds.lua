--[[ keybinds.lua
-- All the keybindings, including whichkey bindings are defined here.
--]]

local keymap = vim.keymap;
local telescope = require("telescope")
local builtin = require('telescope.builtin')
local get_cursor = require('telescope.themes').get_cursor({})
telescope.load_extension("file_browser")

-- TODO: Switch to using which-key (https://github.com/folke/which-key.nvim)

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
  { 'n', "gx",         url_handler,                                                     "Open URL under the cursor using shell open command" },
  { 'n', "<leader>d",  '"_d',                                                           "Delete without yanking" },
  { 'v', "<leader>d",  '"_d',                                                           "Delete without yanking" },

  -- Notepad --
  { 'n', "<leader>N",  ":Notepad<CR>",                                                  "Open notepad" },

  -- Search & navigation --
  { 'n', "<leader>h",  ":noh<CR>",                                                      "Clear search highlights" },
  { 'n', "<leader>sp", function() builtin.registers() end,                              "Search registers" },
  { 'n', "<leader>sk", function() builtin.keymaps() end,                                "Search keymaps" },
  { 'n', "<leader>f",  function() builtin.git_files() end,                              "Search git files" },
  { 'n', "<leader>sf", function() builtin.find_files() end,                             "Search files" },
  { 'n', "<leader>sg", function() builtin.live_grep() end,                              "Live grep" },
  { 'n', "<leader>ss", function() builtin.current_buffer_fuzzy_find() end,              "Search current buffer" },
  { 'n', "<leader>se", function() telescope.extensions.file_browser.file_browser() end, "Browse files" },
  { 'n', "<leader>sh", function() builtin.help_tags() end,                              "Search help" },
  { 'n', "<leader>sl", function() builtin.search_history() end,                         "Search history" },
  { 'n', "<leader>sc", function() builtin.colorscheme() end,                            "Search colorschemes" },
  { 'n', "<leader>e",  ":NvimTreeToggle<CR>",                                           "File tree toggle" },

  -- Git --
  -- GitHub --
  -- Testing --

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
    function() builtin.spell_suggest(get_cursor) end,
    "[s]pell: toggle spell suggestion window for the word under the cursor",
  },
  {
    'n',
    "<leader>st",
    "<CMD>set spell!<CR>",
    "[s]pell [t]oggle: turn spell check on/off for the current buffer",
  },

  -- Motion --
  {
    'n', "<C-d>", "<C-d>zz", "Scroll down half page and recenter"
  },
  {
    'n', "<C-u>", "<C-u>zz", "Scroll up half page and recenter"
  },
  {
    'i', "<C-a>", "<C-o>A", "Jump to end of line"
  },

  -- Editing --
  {
    'n',
    "<leader>R",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    "Replace word under cursor"
  },

  -- Buffer --
  {
    'n',
    "<leader>bl",
    function() builtin.buffers() end,
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
    'n', "<leader>w", ":w<CR>", "Write",
  },
  {
    'n', "<leader>W", ":wa<CR>", "Write all",
  },
  {
    'n', "<leader>q", ":q<CR>", "Quit",
  },
  {
    'n', "<leader>Q", ":qa<CR>", "Quit all",
  },
  {
    'n', "<leader>c", ":bp<bar>sp<bar>bn<bar>bd<CR>", "Buffer close",
  },

  -- Tab --
  {
    'n',
    "<leader>bt",
    ":ls<CR>:echo '[nvim] Choose a buf to create a new tab w/ (blank: choose curr buf, RET: confirm, ESC: cancel)'<CR>:tab sb<SPACE>",
    "[t]ab: create a new tab",
  },

  -- LSP --
  { 'n', 'K',          function() vim.lsp.buf.hover() end,            "Open manual/doc" },
  { 'n', 'gd',         function() vim.lsp.buf.definition() end,       "Goto definition" },
  { 'n', 'gr',         function() builtin.lsp_references() end,       "Search references" },
  { 'n', '<leader>lj', function() vim.diagnostic.goto_next() end,     "Jump to next diagnostic" },
  { 'n', '<leader>lk', function() vim.diagnostic.goto_prev() end,     "Jump to prev diagnostic" },
  { 'n', '<leader>ll', function() builtin.diagnostics() end,          "Search diagnostics" },
  { 'n', '<leader>lf', function() vim.lsp.buf.format() end,           "Format" },
  { 'n', '<leader>la', function() vim.lsp.buf.code_action() end,      "Code action" },
  { 'n', '<leader>ls', function() builtin.lsp_document_symbols() end, "Search symbols" },
  { 'n', '<leader>lm', function() builtin.man_pages(get_cursor) end,  "Search man pages" },

  -- Plugins --
  { 'n', 'pm',         ":Mason<CR>",                                  "Open Mason" },
  { 'n', 'pl',         ":Lazy<CR>",                                   "Open Lazy" },

  -- Terminal --
  { 't', "<ESC>",      "<C-\\><C-n>",                                 "[ESC]: exit insert mode for the terminal" },
  {
    'n',
    "<leader>T",
    function() --> will be overriden in misc.lua terminal location picker
      vim.cmd("topleft " .. math.ceil(vim.fn.winheight(0) * (1 / 3)) .. "sp | term")
    end,
    "Open terminal",
  },

  -- Other --
  {
    'n',
    "<leader>\\c",
    ":tabnew ~/.config/nvim/init.lua<CR>",
    "Open nvim config (init.lua)",
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
