return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		defaults = {
			file_ignore_patterns = {
				"node_modules",
			},
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		local builtin = require("telescope.builtin")

		-- Normal Mode
		vim.keymap.set("n", "<leader>pf", builtin.find_files, {
			desc = "Telescope: Project Files",
		})

		vim.keymap.set("n", "<C-p>", builtin.git_files, {
			desc = "Telescope: Git Files",
		})

		vim.keymap.set("n", "<leader>ps", builtin.live_grep, {
			desc = "Telescope: Project Search",
		})

		vim.keymap.set("n", "grr", builtin.lsp_references, {
			desc = "Telescope: LSP References",
		})

		vim.keymap.set("n", "gri", builtin.lsp_implementations, {
			desc = "Telescope: LSP Implementations",
		})
	end,
}
