return {
	"robitx/gp.nvim",
	config = function()
		require("gp").setup({
			open_api_key = os.getenv("OPENAI_API_KEY"),
		})

		-- Normal Mode
		vim.keymap.set("n", "<leader>gpt", vim.cmd.GpChatNew)
	end,
}
