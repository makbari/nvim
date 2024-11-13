local Lsp = require("utils.lsp")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end
    end,
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    ft = "javascript,typescript,typescriptreact,svelte",
    opts = {
      auto_override_publish_diagnostics = true,
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      on_attach = function(client, bufnr)
        -- Check if it's a Deno project; if so, detach the TypeScript client
        if Lsp.deno_config_exist() then
          vim.lsp.buf_detach_client(bufnr, client.id)
          return
        end
        require("twoslash-queries").attach(client, bufnr)
      end,
      root_dir = function(fname)
        local util = require("lspconfig.util")
        -- Use TypeScript tools only if it's not a Deno project and a package.json exists
        if not Lsp.deno_config_exist() and Lsp.get_config_path("package.json") then
          return util.root_pattern("tsconfig.json")(fname)
            or util.root_pattern("package.json", "jsconfig.json", ".git")(fname)
        end
      end,
      settings = {
        code_lens = "off",
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "literals",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayVariableTypeHints = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
    cond = function()
      -- Only load typescript-tools if it's not a Deno project
      return not Lsp.deno_config_exist()
    end,
  },
  
  {
    "marilari88/twoslash-queries.nvim",
    ft = "javascript,typescript,typescriptreact,svelte",
    opts = { is_enabled = false, multi_line = true, highlight = "Type" },
    keys = {
      { "<leader>dt", ":TwoslashQueriesEnable<cr>", desc = "Enable twoslash queries" },
      { "<leader>dd", ":TwoslashQueriesInspect<cr>", desc = "Inspect twoslash queries" },
    },
  },
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
}
