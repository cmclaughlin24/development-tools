return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.config")

		config.setup({
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"diff",
				"go",
				"html",
				"javascript",
				"jsdoc",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			sync_install = false,
			auto_install = true,
		})
	end,
}
