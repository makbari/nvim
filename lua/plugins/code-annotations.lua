return {
  -- JsDoc generator
  {
    "heavenshell/vim-jsdoc",
    ft = "javascript,typescript,typescriptreact,svelte",
    cmd = "JsDoc",
    keys = {
      { "<leader>jd", "<cmd>JsDoc<cr>", desc = "JsDoc" },
    },
    -- make sure that you will have lehre install locally on plugin folder, refer https://github.com/heavenshell/vim-jsdoc#manual-installation
    build = "make install",
  },
  -- better code annotation
  {
    "danymat/neogen",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local neogen = require("neogen")

      neogen.setup({
        snippet_engine = "luasnip",
      })
    end,
    keys = {
      {
        "<leader>ng",
        function()
          require("neogen").generate()
        end,
        desc = "Generate code annotations",
      },
      {
        "<leader>nf",
        function()
          require("neogen").generate({ type = "func" })
        end,
        desc = "Generate Function Annotation",
      },
      {
        "<leader>nt",
        function()
          require("neogen").generate({ type = "type" })
        end,
        desc = "Generate Type Annotation",
      },
    },
  },
}
