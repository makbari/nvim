local Lsp = require("utils.lsp")

return {
  {
    "lvimuser/lsp-inlayhints.nvim",
    ft = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact", "svelte", "go", "rust" },
    opts = {
      debug_mode = true,
    },
    config = function(_, options)
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- Check if this is a Deno or TypeScript project before attaching inlay hints
          local is_deno_project = Lsp.deno_config_exist()
          local is_ts_project = Lsp.get_config_path("package.json") ~= nil

          if client.name == "denols" and is_deno_project then
            require("lsp-inlayhints").on_attach(client, bufnr)
          elseif client.name == "ts_ls" and is_ts_project then
            require("lsp-inlayhints").on_attach(client, bufnr)
          end
        end,
      })

      require("lsp-inlayhints").setup(options)

      -- Keymap to toggle inlay hints
      vim.api.nvim_set_keymap(
        "n",
        "<leader>uh",
        "<cmd>lua require('lsp-inlayhints').toggle()<CR>",
        { noremap = true, silent = true, desc = "Toggle Inlay Hints" }
      )
    end,
  },
  {
    "Wansmer/symbol-usage.nvim",
    opts = {
      vt_position = "end_of_line",
      text_format = function(symbol)
        if symbol.references then
          local usage = symbol.references <= 1 and "usage" or "usages"
          local num = symbol.references == 0 and "no" or symbol.references
          return string.format(" 󰌹 %s %s", num, usage)
        else
          return ""
        end
      end,
    },
  },
}
