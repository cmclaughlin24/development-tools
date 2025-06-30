return {
	"stevearc/conform.nvim",
	events = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		-- TODO: Add missing formatters for other languages.
		-- NOTE: Make sure to install formatters w/:Mason command.
		conform.setup({
			formatters_by_ft = {
				css = { "prettierd", "prettier", stop_after_first = true },
				go = { "goimports", "gofmt" },
				html = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
			},
		})

		-- Normal Mode
		vim.keymap.set({ "n", "x" }, "<leader>ff", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Conform: Format File" })
	end,
}
