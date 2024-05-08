return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- keys = {
  --   -- git
  --   { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
  --   { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
  -- },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>pf", function()
      builtin.find_files({ hidden = true })
    end)
    vim.keymap.set("n", "<C-p>", builtin.git_files, {})
    vim.keymap.set("n", "<leader>ps", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
  end,
}
