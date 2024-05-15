return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- event = "VeryLazy",
  lazy = false,

  keys = {
    {
      "<C-e>",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon toggle menu",
    },
    {
      "<leader>a",
      function()
        local harpoon = require("harpoon")
        harpoon:list():add()
      end,
      desc = "Harpoon Add File",
    },
    {
      "<leader>h",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(1)
      end,
      desc = "Harpoon: Mark 1",
    },
    {
      "<leader>j",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(2)
      end,
      desc = "Harpoon: Mark 2",
    },
    {
      "<leader>k",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(3)
      end,
      desc = "Harpoon: Mark 3",
    },
    {
      "<leader>l",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(4)
      end,
      desc = "Harpoon: Mark 4",
    },
    {
      "<leader><C-p>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():next()
      end,
      desc = "Harpoon Next",
    },
    {
      "<leader><C-n>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():prev()
      end,
      desc = "Harpoon Prev",
    },
  },
  config = function(_, options)
    local status_ok, harpoon = pcall(require, "harpoon")
    if not status_ok then
      return
    end

    -- REQUIRED
    harpoon:setup(options)
    -- REQUIRED
    local tele_status_ok, _ = pcall(require, "telescope")
    if not tele_status_ok then
      return
    end

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      if #file_paths == 0 then
        vim.notify("No mark found", vim.log.levels.INFO, { title = "Harpoon" })
        return
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    vim.keymap.set("n", "<leader>fm", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window" })
  end,
}
