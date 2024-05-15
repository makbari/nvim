return {
    {
      "nvim-neotest/neotest",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        -- add adapter for neotest
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-vim-test",
        "haydenmeade/neotest-jest",
        "marilari88/neotest-vitest",
        "markemmons/neotest-deno",
        "nvim-neotest/neotest-go",
        "rouge8/neotest-rust",
        "theutz/neotest-pest",
        "nvim-neotest/nvim-nio"
      },
      opts = {
        adapters = {
          ["neotest-deno"] = {},
          ["neotest-jest"] = {},
          ["neotest-vitest"] = {},
          ["neotest-vim-test"] = {
            ignore_file_types = { "python", "vim", "lua", "go", "rust" },
          },
          ["neotest-python"] = {},
          ["neotest-go"] = {},
          ["neotest-rust"] = {},
          ["neotest-pest"] = {
            pest_cmd = function()
              return "vendor/bin/pest"
            end,
          },
        },
      },
    },
  }
  