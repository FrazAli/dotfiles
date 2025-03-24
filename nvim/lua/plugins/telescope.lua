return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy [f]ind [f]iles in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy [f]ind [r]ecent files" })
		keymap.set("n", "<leader>lg", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [s]tring in cwd" })
		keymap.set(
			"n",
			"<leader>ss",
			"<cmd>Telescope grep_string<cr>",
			{ desc = "[F]ind string under [c]ursor in cwd" }
		)
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[F]ind [b]uffers by name" })
	end,
}
