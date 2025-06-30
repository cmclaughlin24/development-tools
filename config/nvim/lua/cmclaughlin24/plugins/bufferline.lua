return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		options = {
			separator_style = "thin",
			always_show_bufferline = false,
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer",
					text_align = "center",
					separator = true,
				},
			},
			diagnostics = "nvim_lsp",
		},
	},
	config = function(_, opts)
		local bufferline = require("bufferline")
		bufferline.setup(opts)

		-- Normal Mode
		vim.keymap.set("n", "<C-k>", vim.cmd.BufferLineCycleNext)
		vim.keymap.set("n", "<C-j>", vim.cmd.BufferLineCyclePrev)
	end,
}
