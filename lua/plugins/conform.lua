local Lsp = require("utils.lsp")

return {
  -- Setup config for formatter
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      -- Add keymap for show info
      { "<leader>cn", "<cmd>ConformInfo<cr>", desc = "Conform Info" },
    },
    opts = {
      formatters_by_ft = {
        fish = {},
        rust = { "rustfmt" },
        yaml = { { "prettierd", "prettier", "dprint" } },
        ["markdown"] = { { "prettierd", "prettier", "dprint" } },
        ["markdown.mdx"] = { { "prettierd", "prettier" } },
        ["javascript"] = { { "prettierd", "prettier" } },
        ["typescript"] = { { "deno_fmt", "prettierd", "prettier", "dprint" } },
        lua = { "stylua" },
        json = { "jq" },
      },

      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
      formatters = {
        deno_fmt = {
          condition = function()
            return Lsp.deno_config_exist()
          end,
        },
        dprint = {
          condition = function()
            return Lsp.dprint_config_exist()
          end,
        },
        jq = {
          command = "jq",
          args = { "." },
          stdin = true,
        },
      },
    },
  },
}
