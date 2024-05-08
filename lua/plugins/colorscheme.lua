return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    name = "tokyonight",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup()

      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
