--[[ plugins.lua
-- This file does:
--   - Initialize the list of plug-ins to be installed
--   - Bootstrap Lazy plugin manager and install plug-ins
--   - Initialize plug-ins using eacch setup() function
--   - For some plug-ins, provide a small configuration work in `config`
--     This is limited to basic config, and extensive config for some plug-ins will be done elsewhere
--   - For some plug-ins, install external dependencies
--]]

-- Plug-in list
local plugins = {
  -- dependencies
  "nvim-lua/plenary.nvim",       --> Lua function library for Neovim (used by Telescope)
  "nvim-tree/nvim-web-devicons", --> Icons for barbar, Telescope, and more

  -- UI
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true
    },
  },
  "projekt0n/github-nvim-theme",
  "xiyaowong/transparent.nvim",

  -- Buffer & tabs scoping
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = true
  },
  {
    "tiagovla/scope.nvim",
    config = true
  },

  -- Syntax, file, search
  { "nvim-treesitter/nvim-treesitter", }, --> Incremental highlighting
  {
    "nvim-telescope/telescope.nvim",      --> Expandable fuzzy finer
    config = function()
      require('telescope').setup({
        defaults = {
          layout_strategy = 'flex'
        }
      })
    end
  },
  { "nvim-telescope/telescope-file-browser.nvim", }, --> File browser extension for Telescope
  {
    "nvim-tree/nvim-tree.lua",                      --> File tree
    config = function()
      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup()

      -- Automatically open Nvimtree if directory is open
      local open_nvim_tree = function(data)
        -- buffer is a directory
        if vim.fn.isdirectory(data.file) ~= 1 then return end
        vim.cmd.cd(data.file)                --> change to the directory
        require("nvim-tree.api").tree.open() --> open the tree
      end
      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    end,
  },
  {
    "stevearc/oil.nvim", --> Manage files like Vim buffer; currently testing!
    config = function() require("oil").setup() end,
  },
  {
    "lewis6991/gitsigns.nvim", --> Git information
    config = true
  },
  {
    "windwp/nvim-autopairs", --> Autopair
    config = true
  },
  "tpope/vim-surround",
  "tpope/vim-commentary",          --> Commenting region
  {
    "norcalli/nvim-colorizer.lua", --> Color highlighter
    config = true
  },

  -- LSP
  { "neovim/nvim-lspconfig", }, --> Neovim defult LSP engine
  {
    "williamboman/mason.nvim",  --> LSP Manager
    config = true
  },
  "williamboman/mason-lspconfig.nvim", --> Bridge between Mason and lspconfig
  "theopn/friendly-snippets",          --> VS Code style snippet collection
  {
    "L3MON4D3/LuaSnip",                --> Snippet engine that accepts VS Code style snippets
    config = true                      --> Load snippets from friendly snippets
  },
  "saadparwaiz1/cmp_luasnip",          --> nvim_cmp and LuaSnip bridge
  "hrsh7th/cmp-nvim-lsp",              --> nvim-cmp source for LSP engine
  "hrsh7th/cmp-buffer",                --> nvim-cmp source for buffer words
  "hrsh7th/cmp-path",                  --> nvim-cmp source for file path
  "hrsh7th/cmp-cmdline",               --> nvim-cmp source for :commands
  "hrsh7th/cmp-nvim-lua",              --> nvim-cmp source for Neovim API
  "hrsh7th/nvim-cmp",                  --> Completion Engine

  -- Text editing
  {
    "iamcco/markdown-preview.nvim",                       --> MarkdownPreview to toggle
    build = function() vim.fn["mkdp#util#install"]() end, --> Binary installation for markdown-preview
    ft = { "markdown" },
  },
  {
    "lervag/vimtex", --> LaTeX integration
    config = function() vim.g.tex_flavor = "latex" end,
    ft = { "plaintex", "tex" },
  }
}

--- {{{ Lazy.nvim installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins)
--- }}}
