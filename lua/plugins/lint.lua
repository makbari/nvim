return {
  "mfussenegger/nvim-lint",
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      markdown = { "vale" },
      -- markdown = { "markdownlint" },
      -- Need to install golangci-lint
      -- e.g: brew install golangci-lint
      go = { "golangcilint" },
      -- ["*"] = { "cspell", "codespell" },
      -- javascript = { "oxlint" },
      -- typescript = { "oxlint" },
      -- javascriptreact = { "oxlint" },
      -- typescriptreact = { "oxlint" },
    },
  },
  -- init = function()
  --     -- Register oxlint
  --     require("lint").linters.oxlint = {
  --       name = "oxlint",
  --       -- Refer to setup https://oxc-project.github.io/docs/contribute/development.html#cargo-binstall
  --       -- Or use the following command to install
  --       -- cargo install --features allocator --git https://github.com/oxc-project/oxc oxc_cli
  --       cmd = "oxlint",
  --       stdin = false,
  --       args = { "--format", "unix" },
  --       stream = "stdout",
  --       ignore_exitcode = true,
  --       parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
  --         source = "oxlint",
  --         severity = vim.diagnostic.severity.WARN,
  --       }),
  --     }
  --   end,
  config = function()
    local lint = require("lint")

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
