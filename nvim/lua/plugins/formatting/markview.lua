return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "OXY2DEV/markview.nvim" },
	lazy = false,
	config = function()
		local markview = require("markview")
		local presets = require("markview.presets")

		markview.setup({
			-- keep your existing presets
			markdown = {
				headings = presets.headings.marker,
				tables = presets.single,

				-- ↓ Fix list indentation & bullet padding (from the wiki)
				list_items = nil,
			},

			preview = {
				callbacks = {
					on_enable = function(_, wins)
						for _, win in ipairs(wins) do
							-- tables behave: render-markdown manages these; we do it here
							vim.wo[win].wrap = false -- fix table alignment
							vim.wo[win].conceallevel = 0 -- less aggressive than 3
							vim.wo[win].concealcursor = "nc" -- reveal on cursor line (anti-conceal effect)
							vim.wo[win].shiftwidth = 2
						end
					end,
					on_splitview_open = function(_, _, win)
						vim.wo[win].wrap = false
						vim.wo[win].conceallevel = 0
						vim.wo[win].concealcursor = "nc"
					end,
				},
			},
		})
	end,

	-- ... All other options.
}
