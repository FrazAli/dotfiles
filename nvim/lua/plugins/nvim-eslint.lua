-- lua/plugins/nvim-eslint.lua
return {
	"esmuellert/nvim-eslint",
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "astro" },
	config = function()
		require("nvim-eslint").setup({})
	end,
}
