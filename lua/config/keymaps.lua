-- Keymaps are automatically loaded on the VeryLazy event

local keymap = vim.keymap.set
local opts = { silent = true }

-- remap "p" in visual mode to delete the highlighted text without overwriting your yanked/copied text, and then paste the content from the unnamed register.
keymap("v", "p", '"_dP', opts)

-- Copy whole file content to clipboard with C-c
keymap("n", "<C-c>", ":%y+<CR>", opts)

-- Select all text in buffer with Alt-a
keymap("n", "<A-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- keymap("n", "<leader>h", "^", {
--   desc = "Go to start of line",
--   silent = true,
-- })
-- keymap("n", "<leader>l", "$", {
--   desc = "Go to end of line",
--   silent = true,
-- })
