--------- Keybinds ---------

local keymaps_opts = { silent = true, buffer = true }

-- 'q' to close buffer
vim.keymap.set("n", "q", ":close<CR>", keymaps_opts)
