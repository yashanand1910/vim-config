--------- Keybinds ---------

local keymaps_opts = { silent = true }

-- Open PR in browser same as :GBrowse keybind
vim.keymap.set('n', "<leader>gB", ":Octo pr browser<CR>", keymaps_opts)
