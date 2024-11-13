# Description

Initially, I want to have a complete control on the nvim configs, and I did not like the `LazyVim` config
since i do have to disable or override the options.
I found this [config](https://github.com/jellydn/lazy-nvim-ide) which is well structured, but still modified the
original config.

It uses `lazy.nvim` as a plugin manager for Neovim.

I want to have a editor to work with both `typescript` and `deno` projects.

### requirements

- there is no special requirements.

### key remaps

- `leader`: `space` is the set as a global leader.
- `<leader>po`: opens up the file explorer
- `<C-c>`: Copy whole file content to clipboard
- `<A-a>`: Select all text in buffer
  FIXME: for some reason thease two are not working as expected.
- `<leader>h`: Easier access to beggining of the line
- `<leader>l`: Easier access to end of the line

## Keybindings

### LSP
- `<leader>cm`: Open Mason

### Telescope
- `<leader>ff`: Find files
- `<leader>fg`: Live grep
- `<leader>fb`: List open buffers
- `<leader>fh`: Find help tags

### Tree-sitter
- `<leader>ut`: Toggle Treesitter Context

### Undo Tree
- `<leader>uT`: Undo Tree Toggle

### Zen Mode
- `<leader>zz`: Toggle Zen Mode with number and relative number
- `<leader>zZ`: Toggle Zen Mode without number and relative number

### SSR (Structural Search and Replace)
- `<leader>bs`: Structural Search and Replace

### Vim Maximizer
- `<leader>sm`: Maximize/minimize a split

### Nvim Tree
- `<leader>ee`: Toggle file explorer
- `<leader>ef`: Toggle file explorer on current file
- `<leader>ec`: Collapse file explorer
- `<leader>er`: Refresh file explorer


### Symbols Outline
- `<leader>o`: Toggle Symbols Outline
- `<Esc>` or `q`: Close Symbols Outline
- `<Cr>`: Go to location
- `o`: Focus location
- `<C-space>`: Hover symbol
- `K`: Toggle preview
- `r`: Rename symbol
- `a`: Code actions
- `h`: Fold
- `l`: Unfold
- `W`: Fold all
- `E`: Unfold all
- `R`: Fold reset

### LSP Inlay Hints
- `<leader>uh`: Toggle Inlay Hints

### Illuminate
- `]]`: Next Reference
- `[[`: Previous Reference

### Refactoring
- `<leader>rm` (visual mode): Refactoring menu
- `<leader>dv` (normal and visual mode): Print below variables
- `<leader>dV` (normal and visual mode): Print above variables
- `<leader>dc`: Clear debugging

### Aerial
- `<leader>ta`: Toggle Aerial
- `{`: Go to previous symbol
- `}`: Go to next symbol
- `<leader>fi`: Open Aerial with Telescope

### Lazygit
- `]h`: Next Hunk
- `[h`: Previous Hunk
- `<leader>ghs`: Stage Hunk
- `<leader>ghr`: Reset Hunk
- `<leader>ghS`: Stage Buffer
- `<leader>ghu`: Undo Stage Hunk
- `<leader>ghR`: Reset Buffer
- `<leader>ghp`: Preview Hunk Inline
- `<leader>ghb`: Blame Line
- `<leader>ghd`: Diff This
- `<leader>ghD`: Diff This ~
- `ih`: GitSigns Select Hunk

### Goto Preview
- `gpt`: Preview Type Definition
- `gpi`: Preview Implementation
- `gpD`: Preview Declaration
- `gP`: Close All Preview Windows
- `gpr`: Preview References

### FZF Lua
- `<C-g>`: Find Grep
- `<C-g>` (visual mode): Search Grep in visual selection
- `<leader>sw` (visual mode): Search word in visual selection (git root)
- `<leader>fr`: Find Recent Files
- `<leader>/`: Grep Files at current directory
- `<leader>ff`: Find Git Files
- `<leader>fc`: Find Neovim Configs
- `<leader>sb`: Search Current Buffer
- `<leader>sB`: Search Lines in Open Buffers
- `<leader>sw`: Search word under cursor (git root)
- `<leader>sW`: Search WORD under cursor (git root)
- `<leader>gs`: Git Status
- `<leader>gc`: Git Commits
- `<leader>gb`: Git Branches
- `<leader>gB`: Git Buffer Commits
- `<leader>sa`: Find Actions
- `<leader>s:`: Find Command History
- `<leader>ss`: LSP Document Symbols
- `<leader>sS`: LSP Workspace Symbols
- `<leader>si`: LSP Incoming Calls
- `<leader>so`: LSP Outgoing Calls
- `<leader>sk`: Search Keymaps
- `<leader>sm`: Search Marks
- `<leader>st`: Search Tmux buffers
- `<leader>sc`: Search colorschemes
- `<leader>sh`: Search Help
- `<leader>sq`: Search Quickfix

### Code Annotations
- `<leader>jd`: JsDoc
- `<leader>ci`: Neogen - Annotation generator

### Harpoon
- `<C-e>`: Harpoon toggle menu
- `<leader>a`: Harpoon Add File
- `<leader>h`: Harpoon: Mark 1
- `<leader>j`: Harpoon: Mark 2
- `<leader>k`: Harpoon: Mark 3
- `<leader>l`: Harpoon: Mark 4
- `<leader><C-p>`: Harpoon: Next Mark


### Comment
- `gcc`: Line-comment toggle
- `gbc`: Block-comment toggle
- `gc`: Line-comment in NORMAL and VISUAL mode
- `gb`: Block-comment in NORMAL and VISUAL mode
- `gcO`: Add comment on the line above
- `gco`: Add comment on the line below
- `gcA`: Add comment at the end of line
