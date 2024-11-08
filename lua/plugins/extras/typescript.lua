return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end
    end,
  },
  -- -- correctly setup lspconfig
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     -- make sure mason installs the server
  --     servers = {
  --       --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
  --       --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
  --       tsserver = {
  --         enabled = false,
  --       },
  --       ts_ls = {
  --         enabled = false,
  --       },
  --       vtsls = {
  --         -- explicitly add default filetypes, so that we can extend
  --         -- them in related extras
  --         filetypes = {
  --           "javascript",
  --           "javascriptreact",
  --           "javascript.jsx",
  --           "typescript",
  --           "typescriptreact",
  --           "typescript.tsx",
  --         },
  --         settings = {
  --           complete_function_calls = true,
  --           vtsls = {
  --             enableMoveToFileCodeAction = true,
  --             autoUseWorkspaceTsdk = true,
  --             experimental = {
  --               completion = {
  --                 enableServerSideFuzzyMatch = true,
  --               },
  --             },
  --           },
  --           typescript = {
  --             updateImportsOnFileMove = { enabled = "always" },
  --             suggest = {
  --               completeFunctionCalls = true,
  --             },
  --             inlayHints = {
  --               enumMemberValues = { enabled = true },
  --               functionLikeReturnTypes = { enabled = true },
  --               parameterNames = { enabled = "literals" },
  --               parameterTypes = { enabled = true },
  --               propertyDeclarationTypes = { enabled = true },
  --               variableTypes = { enabled = false },
  --             },
  --           },
  --         },
  --         keys = {
  --           {
  --             "gD",
  --             function()
  --               local params = vim.lsp.util.make_position_params()
  --               LazyVim.lsp.execute({
  --                 command = "typescript.goToSourceDefinition",
  --                 arguments = { params.textDocument.uri, params.position },
  --                 open = true,
  --               })
  --             end,
  --             desc = "Goto Source Definition",
  --           },
  --           {
  --             "gR",
  --             function()
  --               LazyVim.lsp.execute({
  --                 command = "typescript.findAllFileReferences",
  --                 arguments = { vim.uri_from_bufnr(0) },
  --                 open = true,
  --               })
  --             end,
  --             desc = "File References",
  --           },
  --           {
  --             "<leader>co",
  --             LazyVim.lsp.action["source.organizeImports"],
  --             desc = "Organize Imports",
  --           },
  --           {
  --             "<leader>cM",
  --             LazyVim.lsp.action["source.addMissingImports.ts"],
  --             desc = "Add missing imports",
  --           },
  --           {
  --             "<leader>cu",
  --             LazyVim.lsp.action["source.removeUnused.ts"],
  --             desc = "Remove unused imports",
  --           },
  --           {
  --             "<leader>cD",
  --             LazyVim.lsp.action["source.fixAll.ts"],
  --             desc = "Fix all diagnostics",
  --           },
  --           {
  --             "<leader>cV",
  --             function()
  --               LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
  --             end,
  --             desc = "Select TS workspace version",
  --           },
  --         },
  --       },
  --     },
  --     setup = {
  --       --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
  --       --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
  --       tsserver = function()
  --         -- disable tsserver
  --         return true
  --       end,
  --       ts_ls = function()
  --         -- disable tsserver
  --         return true
  --       end,
  --     },
  --   },
  -- },

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

