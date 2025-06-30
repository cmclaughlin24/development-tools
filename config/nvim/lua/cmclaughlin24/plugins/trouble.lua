return {
	"folke/trouble.nvim",
	config = function()
		-- Normal Mode
		vim.keymap.set("n", "<leader>tt", function()
			require("trouble").toggle({ mode = "diagnostics" })
		end, { desc = "Trouble: Toggle Trouble" })
	end,
}
