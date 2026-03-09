return {
	"robitx/gp.nvim",
	config = function()
		require("gp").setup({
			-- open_api_key = os.getenv("OPENAI_API_KEY"),
			providers = {
				copilot = {
					disable = false,
					secret = {
						"bash",
						"-c",
						"cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\".*//'",
					},
				},
			},
		})

		-- Normal Mode
		vim.keymap.set("n", "<leader>gpn", vim.cmd.GpChatNew)
		vim.keymap.set("n", "<leader>gpf", vim.cmd.GpChatFinder)
	end,
}
