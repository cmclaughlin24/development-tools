return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		local telescope_config = require("telescope.config").values

		harpoon.setup()

		local function toggle_telescope(harpoon_files)
			local file_paths = {}

			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			local make_finder = function()
				local paths = {}

				for _, item in ipairs(harpoon_files.items) do
					table.insert(paths, item.value)
				end

				return require("telescope.finders").new_table({
					results = paths,
				})
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = telescope_config.file_previewer({}),
					sorter = telescope_config.generic_sorter({}),
					attach_mappings = function(prompt_buffer_number, map)
						map("i", "<C-d>", function()
							-- FIXME: Fix removal mapping for telescope & harpoon
							local state = require("telescope.actions.state")
							local selected_entry = state.get_selected_entry()
							local current_picker = state.get_current_picker(prompt_buffer_number)

							harpoon:list():remove(selected_entry)
							current_picker:refresh(make_finder())
						end)

						return true
					end,
				})
				:find()
		end

		-- Normal Mode
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Harpoon: Harpoon File" })
		vim.keymap.set("n", "<C-h>", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Harpoon: Open Quick Menu" })

		for i = 1, 5 do
			vim.keymap.set("n", "<leader>" .. i, function()
				require("harpoon"):list():select(i)
			end, { desc = "Harpoon: Select File " .. i })
		end
		--[[
		vim.keymap.set("n", "<C-j>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-k>", function()
			harpoon:list():next()
		end)
    --]]
	end,
}
