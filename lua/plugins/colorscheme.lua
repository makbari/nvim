return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    name = "tokyonight",
    opts = {
      style = "moon",
    },
    config = function()
      require("tokyonight").setup()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
}
