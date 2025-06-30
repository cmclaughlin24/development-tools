return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- NOTE: Required by nvim-dap-ui
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup({})

		-- Use nvim-dap events to open and close windows automatically.
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end

		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Mason
		require("mason-nvim-dap").setup({
			ensure_installed = {
				"delve", -- Go
			},
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		-- Define diagnostic symbols
		vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "red", linehl = "", numhl = "" })

		-- Normal Mode
		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {
			desc = "DAP: Toggle Breakpoint",
		})

		vim.keymap.set("n", "<leader>dc", dap.continue, {
			desc = "DAP: Continue",
		})
	end,
}
