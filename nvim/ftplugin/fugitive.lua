--------- Keybinds ---------

local keymaps_opts = { silent = true }

-- 'q' to close buffer
vim.keymap.set('n', "q", ":close<CR>", keymaps_opts)
