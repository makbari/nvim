local Lsp = require("utils.lsp")

return {
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
      opts = {
        servers = {
          ts_ls = {
            settings = {
              completions = {
                completeFunctionCalls = true,
              },
              typescript = {
                preferences = {
                  importModuleSpecifier = "relative",
                },
              },
            },
          },
        },
        inlay_hints = {
          enabled = true,
        },
        codelens = {
          enabled = false,
        },
        format = {
          timeout_ms = nil,
        },
      },
      config = function(_, opts)
        local nvim_lsp = require("lspconfig")
        if Lsp.deno_config_exist() then
            nvim_lsp.denols.setup({
              -- Omitting some options
              root_dir = nvim_lsp.util.root_pattern("deno.json"),
            })
          else
            nvim_lsp.ts_ls.setup({
              -- Omitting some options
              root_dir = nvim_lsp.util.root_pattern("package.json"),
            })
          end
        local servers = opts.servers
  
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local function setup(server)
          local server_opts = vim.tbl_deep_extend("force", {
            capabilities = vim.deepcopy(capabilities),
          }, servers[server] or {})
          require("lspconfig")[server].setup(server_opts)
        end
  
        local have_mason, mlsp = pcall(require, "mason-lspconfig")
        local all_mslp_servers = {}
        if have_mason then
          all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
        end
  
        local ensure_installed = {} ---@type string[]
        for server, server_opts in pairs(servers) do
          if server_opts then
            server_opts = server_opts == true and {} or server_opts
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            elseif server_opts.enabled ~= false then
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
  
        if have_mason then
          mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
        end
      end,
    },
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
      build = ":MasonUpdate",
      opts = {
        ensure_installed = {
          "lua-language-server",
          "json-lsp",
          "stylua",
          "typescript-language-server",
        },
      },
      config = function(_, opts)
        require("mason").setup(opts)
        local mr = require("mason-registry")
        local function ensure_installed()
          for _, tool in ipairs(opts.ensure_installed) do
            local p = mr.get_package(tool)
            if not p:is_installed() then
              p:install()
            end
          end
        end
        if mr.refresh then
          mr.refresh(ensure_installed)
        else
          ensure_installed()
        end
      end,
    },
  }
  