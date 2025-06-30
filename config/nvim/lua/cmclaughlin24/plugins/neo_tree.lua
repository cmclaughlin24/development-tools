return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		open_files_do_not_replace_types = {
			"terminal",
			"Trouble",
			"trouble",
			"qf",
		},
		filesystem = {
			use_libuv_file_watcher = true,
			bind_to_cwd = false,
		},
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)
		local command = require("neo-tree.command")

		-- Normal Mode
		vim.keymap.set("n", "<leader>fe", function()
			command.execute({ toggle = true })
		end, { desc = "NeoTree: File Explorer" })

		vim.keymap.set("n", "<leader>ge", function()
			command.execute({ source = "git_status", toggle = true })
		end, { desc = "NeoTree: Git Explorer" })
	end,
}
