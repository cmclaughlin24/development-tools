return {
	"tpope/vim-fugitive",
	config = function()
		-- Normal Mode
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
	end,
}
