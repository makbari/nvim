return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- event = "VeryLazy",
  lazy = false,
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Harpoon: Add buffer" })
    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon: Toggle quick menu" })

    vim.keymap.set("n", "<leader>h", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon: Mark 1" })
    vim.keymap.set("n", "<leader>j", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon: Mark 2" })
    vim.keymap.set("n", "<leader>k", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon: Mark 3" })
    vim.keymap.set("n", "<leader>l", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon: Mark 4" })

    -- vim.keymap.set("n", "<leader><F5>", function()
    --   harpoon:list():clear()
    -- end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader><C-p>", function()
      harpoon:list():prev()
    end, { desc = "Harpoon prev" })
    vim.keymap.set("n", "<leader><C-n>", function()
      harpoon:list():next()
    end, { desc = "Harpoon next" })
  end,
}
