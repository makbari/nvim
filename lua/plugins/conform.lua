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
        -- Conform will run multiple formatters sequentially
        -- go = { "goimports", "gofmt" },
        -- python = { "ruff_fix", "ruff_format" },
        -- php = { "pint" },
        rust = { "rustfmt" },
        -- Use a sub-list to run only the first available formatter
        yaml = { { "prettierd", "prettier", "dprint" } },
        ["markdown"] = { { "prettierd", "prettier", "dprint" } },
        ["markdown.mdx"] = { { "prettierd", "prettier", "dprint" } },
        ["javascript"] = { { "deno_fmt", "prettierd", "prettier", "dprint" } },
        -- ["javascriptreact"] = { "rustywind", { "deno_fmt", "prettierd", "prettier", "dprint" } },
        ["typescript"] = { { "deno_fmt", "prettierd", "prettier", "dprint" } },
        -- ["typescriptreact"] = { "rustywind", { "deno_fmt", "prettierd", "prettier", "dprint" } },
        -- ["svelte"] = { "rustywind", { "deno_fmt", "prettierd", "prettier", "dprint" } },
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
    -- config = function()
    --   local conform = require("conform")
    --   conform.setup({
    --     formatters_by_ft = {
    --       javascript = { "prettier" },
    --       typescript = { "prettier" },
    --       javascriptreact = { "prettier" },
    --       typescriptreact = { "prettier" },
    --       svelte = { "prettier" },
    --       css = { "prettier" },
    --       html = { "prettier" },
    --       json = { "prettier" },
    --       yaml = { "prettier" },
    --       markdown = { "prettier" },
    --       graphql = { "prettier" },
    --       liquid = { "prettier" },
    --       lua = { "stylua" },
    --     },
    --     format_on_save = {
    --       lsp_fallback = true,
    --       async = false,
    --       timeout_ms = 1000,
    --     },
    --   })

    --   vim.keymap.set({ "n", "v" }, "<leader>mp", function()
    --     conform.format({
    --       lsp_fallback = true,
    --       async = false,
    --       timeout_ms = 1000,
    --     })
    --   end, { desc = "Format file or range (in visual mode)" })
    -- end,
  },
}
