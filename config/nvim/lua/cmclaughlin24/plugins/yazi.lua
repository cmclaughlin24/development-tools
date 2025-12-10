return {
	"mikavilpas/yazi.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	config = function()
		require("yazi").setup({
			opts = {
				open_for_directories = false,
			},
		})

		-- Normal Mode
		vim.keymap.set("n", "<leader>fe", "<cmd>Yazi cwd<cr>", { desc = "Yazi: File Explorer" })
		vim.keymap.set("n", "<leader>cd", "<cmd>Yazi<cr>", { desc = "Yazi: Current Directory" })
	end,
	init = function()
		-- NOTE: Mark netrw as loaded so it's not loaded at all.
		vim.g.loaded_netrwPlugin = 1
	end,
}
