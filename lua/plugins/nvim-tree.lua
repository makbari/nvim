local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  local keymap = vim.keymap -- for conciseness

  keymap.set("n", "l", api.node.open.edit, opts("Open"))
  keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
  keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
  keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
  keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
  keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
end

-- NOTE: File Explorer
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  cmd = {
    "NvimTreeOpen",
    "NvimTreeToggle",
    "NvimTreeFocus",
    "NvimTreeFindFile",
    "NvimTreeFindFileToggle",
  },
  opts = {
    on_attach = on_attach,
    diagnostics = {
      enable = false,
      icons = {
        hint = "󰌵",
        info = "",
        warning = "",
        error = "",
      },
    },
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    git = {
      enable = true,
      ignore = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
      timeout = 5000,
    },
    view = {
      cursorline = false,
      float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
          relative = "editor",
          border = "rounded",
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    },

    renderer = {
      highlight_git = false,
      -- root_folder_label = false,
      root_folder_label = ":~:s?$?",
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },

        glyphs = {
          default = "󰈚",
          symlink = "",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = "",
          },

          git = {
            -- unstaged = "",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "U",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.cmd("NvimTreeOpen") -- Open Nvim Tree on startup
  end,
}
