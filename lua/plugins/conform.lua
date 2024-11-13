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
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format" }
          else
            return { "isort", "black" }
          end
        end,
        rust = { "rustfmt", lsp_format = "fallback" },
        yaml = {  "prettierd", "prettier", "dprint"  },
        ["markdown"] = { "prettierd", "prettier", "dprint" },
        ["markdown.mdx"] = { "prettierd", "prettier" },
        ["javascript"] = { "prettierd", "prettier" },
        ["typescript"] = { "deno_fmt", "prettierd", "prettier", "dprint"},
        lua = { "stylua" },
        json = { "jq" },
      },

      format_on_save = {
        lsp_fallback = "fallback",
        async = false,
        timeout_ms = 500,
      },
      formatters = {
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
