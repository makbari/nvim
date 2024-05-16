local utils = require("utils.path")
return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      hls = {
        border = "FloatBorder",
        cursorline = "Visual",
        cursorlinenr = "Visual",
      },
      fzf_opts = {
        ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
        ["--info"] = false,
        ["--border"] = false,
        ["--preview-window"] = false,
      },
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.55,
        preview = {
          layout = "flex",
          flip_columns = 130,
          scrollbar = "float",
        },
      },
      files = {
        multiprocess = true,
        git_icons = false,
        file_icons = false,
      },
      grep = {
        multiprocess = true,
      },
      git = {
        files = {
          multiprocess = true,
        },
        status = {
          winopts = {
            preview = { vertical = "down:70%", horizontal = "right:70%" },
          },
        },
        commits = { winopts = { preview = { vertical = "down:60%" } } },
        bcommits = { winopts = { preview = { vertical = "down:60%" } } },
        branches = {
          winopts = {
            preview = { vertical = "down:75%", horizontal = "right:75%" },
          },
        },
      },
      lsp = {
        async_or_timeout = true,
        symbols = {
          path_shorten = 1,
        },
        code_actions = {
          winopts = {
            preview = { layout = "reverse-list", horizontal = "right:75%" },
          },
        },
      },
    },
    config = function(_, options)
      local fzf_lua = require("fzf-lua")

      -- Refer https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/defaults.lua#L69 for default keymaps
      fzf_lua.setup(options)

      -- Automatic sizing of height/width of vim.ui.select
      fzf_lua.register_ui_select(function(_, items)
        local min_h, max_h = 0.60, 0.80
        local h = (#items + 4) / vim.o.lines
        if h < min_h then
          h = min_h
        elseif h > max_h then
          h = max_h
        end
        return { winopts = { height = h, width = 0.80, row = 0.40 } }
      end)

      -- LSP handlers setup
      vim.lsp.handlers["textDocument/codeAction"] = fzf_lua.lsp_code_actions
      vim.lsp.handlers["textDocument/definition"] = fzf_lua.lsp_definitions
      vim.lsp.handlers["textDocument/declaration"] = fzf_lua.lsp_declarations
      vim.lsp.handlers["textDocument/typeDefinition"] = fzf_lua.lsp_typedefs
      vim.lsp.handlers["textDocument/implementation"] = fzf_lua.lsp_implementations
      vim.lsp.handlers["textDocument/references"] = fzf_lua.lsp_references
      vim.lsp.handlers["textDocument/documentSymbol"] = fzf_lua.lsp_document_symbols
      vim.lsp.handlers["workspace/symbol"] = fzf_lua.lsp_workspace_symbols
      vim.lsp.handlers["callHierarchy/incomingCalls"] = fzf_lua.lsp_incoming_calls
      vim.lsp.handlers["callHierarchy/outgoingCalls"] = fzf_lua.lsp_outgoing_calls
    end,
    keys = {
      { "<C-g>", "<cmd> :FzfLua grep_project<CR>", desc = "Find Grep" },
      {
        "<C-g>",
        function()
          local root_dir = utils.root()
          local fzf_lua = require("fzf-lua")
          fzf_lua.setup({
            grep = {
              actions = { ["ctrl-r"] = { fzf_lua.actions.toggle_ignore } },
            },
          })

          fzf_lua.grep_visual({
            cwd = root_dir,
            rg_opts = "--column --hidden --smart-case --color=always --no-heading --line-number -g '!{.git,node_modules}/'",
            multiprocess = true,
          })
        end,
        desc = "Search Grep in visual selection",
        mode = "v",
      },
      {
        "<leader>sw",
        function()
          local root_dir = utils.git()
          local fzf_lua = require("fzf-lua")
          fzf_lua.setup({
            grep = {
              actions = { ["ctrl-r"] = { fzf_lua.actions.toggle_ignore } },
            },
          })

          fzf_lua.grep_visual({
            cwd = root_dir,
            rg_opts = "--column --hidden --smart-case --color=always --no-heading --line-number -g '!{.git,node_modules}/'",
            multiprocess = true,
          })
        end,
        desc = "Search word in visual selection (git root)",
        mode = "v",
      },
      {
        "<leader>fr",
        function()
          local root_dir = utils.git()
          require("fzf-lua").oldfiles({ cwd = root_dir })
        end,
        desc = "Find Recent Files",
      },
      {
        "<leader>/",
        function()
          local root_dir = utils.root()
          require("fzf-lua").live_grep({ cwd = root_dir, multiprocess = true })
        end,
        desc = "Grep Files at current directory",
      },
      {
        "<leader>ff",
        function()
          local root_dir = utils.git()
          require("fzf-lua").git_files({ cwd = root_dir })
        end,
        desc = "Find Git Files",
      },
      {
        "<leader>fc",
        function()
          require("fzf-lua").files({ cwd = "~/.config/nvim" })
        end,
        desc = "Find Neovim Configs",
      },
      { "<leader>sb", "<cmd> :FzfLua grep_curbuf<CR>", desc = "Search Current Buffer" },
      { "<leader>sB", "<cmd> :FzfLua lines<CR>", desc = "Search Lines in Open Buffers" },
      {
        "<leader>sw",
        function()
          local root_dir = utils.git()
          require("fzf-lua").grep_cword({ cwd = root_dir, multiprocess = true })
        end,
        desc = "Search word under cursor (git root)",
      },
      {
        "<leader>sW",
        function()
          local root_dir = utils.git()
          require("fzf-lua").grep_cWORD({ cwd = root_dir, multiprocess = true })
        end,
        desc = "Search WORD under cursor (git root)",
      },
      {
        "<leader>gs",
        function()
          local root_dir = utils.git()
          require("fzf-lua").git_status({ cwd = root_dir })
        end,
        desc = "Git Status",
      },
      { "<leader>gc", "<cmd> :FzfLua git_commits<CR>", desc = "Git Commits" },
      { "<leader>gb", "<cmd> :FzfLua git_branches<CR>", desc = "Git Branches" },
      { "<leader>gB", "<cmd> :FzfLua git_bcommits<CR>", desc = "Git Buffer Commits" },
      { "<leader>sa", "<cmd> :FzfLua commands<CR>", desc = "Find Actions" },
      { "<leader>s:", "<cmd> :FzfLua command_history<CR>", desc = "Find Command History" },
      { "<leader>ss", "<cmd> :FzfLua lsp_document_symbols<CR>", desc = "LSP Document Symbols" },
      { "<leader>sS", "<cmd> :FzfLua lsp_workspace_symbols<CR>", desc = "LSP Workspace Symbols" },
      { "<leader>si", "<cmd> :FzfLua lsp_incoming_calls<CR>", desc = "LSP Incoming Calls" },
      { "<leader>so", "<cmd> :FzfLua lsp_outgoing_calls<CR>", desc = "LSP Outgoing Calls" },
      { "<leader>sk", "<cmd> :FzfLua keymaps<CR>", desc = "Search Keymaps" },
      { "<leader>sm", "<cmd> :FzfLua marks<CR>", desc = "Search Marks" },
      { "<leader>st", "<cmd> :FzfLua tmux_buffers<CR>", desc = "Search Tmux buffers" },
      { "<leader>sc", "<cmd> :FzfLua colorschemes<CR>", desc = "Search colorschemes" },
      { "<leader>sh", "<cmd> :FzfLua help_tags<CR>", desc = "Search Help" },
      { "<leader>sq", "<cmd> :FzfLua quickfix<CR>", desc = "Search Quickfix" },
    },
  },
}
