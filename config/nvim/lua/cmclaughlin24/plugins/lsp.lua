return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
	},
	config = function()
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)

		-- Lsp Configuration
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"angularls",
				"cssls",
				"html",
				"gopls",
				"lua_ls",
				"ts_ls",
			},
			handlers = {
				function(server_name)
                    vim.lsp.config(server_name, {
						capabilities = capabilities,
                    })
					vim.lsp.enable(server_name)
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
							},
						},
					})
				end,
			},
		})

		-- Key Mappings
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "Lsp Actions",
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
				-- vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
				-- vim.keymap.set("n", "gs", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>fr", vim.lsp.buf.rename, opts)
			end,
		})

		-- Autocompeletion
		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "luasnip" },
				{ name = "path" },
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
		})

		-- Diagnostic Configuration
		local diagnosticSymbols = {
			ERROR = " ",
			WARN = " ",
			HINT = " ",
			INFO = "",
		}

		vim.diagnostic.config({
			virtual_text = {
				prefix = function(diagnostic)
					return diagnosticSymbols[vim.diagnostic.severity[diagnostic.severity]]
				end,
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = diagnosticSymbols.ERROR,
					[vim.diagnostic.severity.WARN] = diagnosticSymbols.WARN,
					[vim.diagnostic.severity.HINT] = diagnosticSymbols.HINT,
					[vim.diagnostic.severity.INFO] = diagnosticSymbols.INFO,
				},
			},
		})
	end,
}
