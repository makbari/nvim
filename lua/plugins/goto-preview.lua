return {
  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup({
        width = 120, -- Width of the floating window
        height = 25, -- Height of the floating window
        default_mappings = true, -- Enable/disable default key mappings
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        debug = false, -- Print debug information
        opacity = nil, -- Set opacity to 80%
      })
    end,
  },
}
