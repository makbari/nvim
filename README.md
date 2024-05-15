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

### Plugin and their key remaps
The plugins have their own key remaps.


#### aerial
- `<leader>ta`: aerial toggle
- `{`: aerial prev
- `}`: aerial next
- `<leader>fi`: telescope aerial

#### annotations
- `<leader>jd`: js doc creator for `javascript` and `typescript`
- `<leader>ci`: another annotation generator, supports multiple languages

#### comment
- `gcc`: comment a line or a block in typescript, javascript, html, and css.


#### harpoon
- `<C-e>`: toggle harpoon  
- `<leader>a`: add to the list
- `<leader>[h,j,k,l]`: cycle throught the list items from 1 to 4 

#### lazyGit
the best plugin for managing the changes in file and work with the hunks in line and buffer
- `<leader>lg`: open lazy git interface
- `]h`: next hunk
- `[h`: prev hunk
- `<leader>ghs`: stage hunk
- `<leader>ghr`: reset hunk
- `<leader>ghS`: stage buffer
- `<leader>ghR`: reset buffer
- `<leader>ghU`: undo hunk
- `<leader>ghp`: inline preview
- `<leader>ghb`: git blame
- `<leader>ghd`: git diff hunk
- `<leader>ghD`: git diff buffer


#### ssr
search and replace in a file
- `<leader>bs`: search and replace

#### symbol outline
- `<leader>o`: toggle symbol outline

#### telescope
-`<leader>pf`: finding files in the project
-`<leader>ps`: find word in the project via grep
-`<C-p>`: finding the git files in the project

#### undotree
- `<leader>uT>`: toggle undotree

#### zen mode
- `<leader>zz`
- `<leader>zZ`


