require'nvim-treesitter.configs'.setup {
	ensure_installed = { "typescript", "javascript", "rust", "python", "c", "lua", "vim", "vimdoc", "query"  },

	sync_install = false,

	auto_install = true,

	highlight = {
		enable = true,
	},
}
