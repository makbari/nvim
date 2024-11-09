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
        "sigmaSd/deno-nvim",
        dependencies = { "neovim/nvim-lspconfig" }, -- Assuming lspconfig is needed
        config = function()
          require("deno-nvim").setup({
            server = {
              capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()), -- Assuming you're using cmp for capabilities
              settings = {
                deno = {
                  inlayHints = {
                    parameterNames = {
                      enabled = "all",
                    },
                    parameterTypes = {
                      enabled = true,
                    },
                    variableTypes = {
                      enabled = true,
                    },
                    propertyDeclarationTypes = {
                      enabled = true,
                    },
                    functionLikeReturnTypes = {
                      enabled = true,
                    },
                    enumMemberValues = {
                      enabled = true,
                    },
                  },
                },
              },
            },
          })
        end,
        cond = function()
          return Lsp.deno_config_exist()
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
}