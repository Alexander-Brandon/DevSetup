return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },

  {
 "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        side = "right",
      },
    }
 },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>tc", desc = "Toggle Claude Code terminal" },
      { "<leader>tl", desc = "Toggle CLI terminal" },
    },
    config = function()
      require "configs.toggleterm"
    end,
  },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
