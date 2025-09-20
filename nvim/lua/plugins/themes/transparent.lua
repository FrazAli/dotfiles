-- Usage:
--
-- transparent.nvim automatically transparent all of highlight settings.
-- You can disable it by :TransparentDisable and re-enable it by :TransparentEnable, Toggle it by :TransparentToggle
return {
	"tribela/transparent.nvim",
	event = "VimEnter",
	config = function()
		vim.keymap.set("n", "<C-t>", ":TransparentToggle<CR>", { noremap = true, silent = true })
	end,
}
