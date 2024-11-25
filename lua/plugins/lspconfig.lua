local Lsp = require("utils.lsp")
function print_table(tbl, indent)
  indent = indent or 0
  local formatting = string.rep("  ", indent) -- Add indentation for nested tables

  for key, value in pairs(tbl) do
    if type(value) == "table" then
      print(formatting .. tostring(key) .. ":")
      print_table(value, indent + 1) -- Recursive call for nested tables
    else
      print(formatting .. tostring(key) .. ": " .. tostring(value))
    end
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              codeLens = { enable = true },
              completion = { callSnippet = "Replace" },
            },
          },
        },
      },
      inlay_hints = { enabled = true },
      setup = {},
    },
    config = function(_, opts)
      local nvim_lsp = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Diagnostic symbols in the sign column (gutter)
      for type, icon in pairs({ Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }) do
        vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type })
      end

      -- Setting up Mason and LSP with proper handler setup
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(opts.servers),
      })
      local function setup_ts_or_deno()
        local server_opts = { capabilities = capabilities }

        if Lsp.deno_config_exist() then
          -- Configure for Deno if it's a Deno project
          nvim_lsp.denols.setup(server_opts)
        elseif Lsp.get_config_path("package.json") then
          -- Configure for TypeScript if it's a TypeScript project
          nvim_lsp.ts_ls.setup(vim.tbl_deep_extend("force", server_opts, {
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
          }))
        end
      end

      -- Setup handlers for all servers, including custom setup for ts_ls and denols
      mason_lspconfig.setup_handlers({
        function(server)
          if server == "ts_ls" or server == "denols" then
            setup_ts_or_deno()
          else
            local server_opts =
              vim.tbl_deep_extend("force", { capabilities = capabilities }, opts.servers[server] or {})
            if server.enabled then
              nvim_lsp[server].setup(server_opts)
            end
          end
        end,
      })

      -- LSP Keymaps
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "List references" })
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
      vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Show signature help" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ed", vim.diagnostic.open_float, { desc = "Open diagnostics" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>ih", function()
        vim.lsp.inlay_hint(0, nil)
      end, { desc = "Toggle inlay hints" })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "docker-compose-language-service",
        "json-lsp",
        "stylua",
        "shfmt",
        "pyright",
        "prismals",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local pkg = mr.get_package(tool)
        if not pkg:is_installed() then
          pkg:install()
        end
      end
    end,
  },
}
