return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  "nvim-lua/plenary.nvim",
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  "mg979/vim-visual-multi",
  {
    "j-hui/fidget.nvim",
    branch = "legacy",
    enabled = false,
    config = function()
      require("fidget").setup({
        window = { blend = 0 },
      })
    end,
  },
  -- find and replace
  {
    "windwp/nvim-spectre",
    enabled = false,
    event = "BufRead",
    keys = {
      {
        "<leader>Rr",
        function()
          require("spectre").open()
        end,
        desc = "Replace",
      },
      {
        "<leader>Rw",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Replace Word",
      },
      {
        "<leader>Rf",
        function()
          require("spectre").open_file_search()
        end,
        desc = "Replace Buffer",
      },
    },
  },
  -- Add/change/delete surrounding delimiter pairs with ease
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  -- Indent guide for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {},
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {},
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- Load the plugin lazily before opening a buffer
    config = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("state") .. "/sessions/", -- Directory where sessions will be stored
        need = 0,
        branch = true, -- use git branch to save session
        options = { "buffers", "curdir", "tabpages", "winsize" }, -- Session options
      })
      vim.keymap.set("n", "<leader>qs", function()
        require("persistence").load()
      end)

      vim.keymap.set("n", "<leader>ql", function()
        require("persistence").load()
      end, { desc = "Restore last session" })

      vim.keymap.set("n", "<leader>qd", function()
        require("persistence").stop()
      end, { desc = "Stop persistence" })
    end,
  },
}
