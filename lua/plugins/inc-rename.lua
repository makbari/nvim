return {
    {
      "smjonas/inc-rename.nvim",
      cmd = "IncRename",
      opts = {},
      config = function()
        vim.keymap.set("n", "<leader>rn", "<cmd>IncRename<CR>")
      end,
    },
}