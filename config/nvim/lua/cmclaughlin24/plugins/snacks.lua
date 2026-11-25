return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		local snacks = require("snacks")

		snacks.setup({
			input = { enabled = true },
			notifier = { enabled = true },
			picker = { enabled = true },
			dashboard = {
				enabled = true,
				sections = {
					{
						section = "terminal",
						cmd = "chafa ~/Documents/Repositories/development-tools/imgs/repository-logo.jpg --format symbols --symbols quad --size 60x17 --stretch; sleep .1",
						height = 17,
						padding = 1,
						ttl = 0,
					},
					-- { section = "header" },
					{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
					{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ section = "startup" },
				},
			},
		})

		vim.api.nvim_create_autocmd("LspProgress", {
			callback = function(ev)
				local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
				vim.notify(vim.lsp.status(), "info", {
					id = "lsp_progress",
					title = "LSP Progress",
					opts = function(notif)
						notif.icon = ev.data.params.value.kind == "end" and " "
							or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
					end,
				})
			end,
		})
	end,
}
