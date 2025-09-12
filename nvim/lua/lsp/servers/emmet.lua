return {
	"emmet_language_server",
	{
		cmd = { "emmet-language-server", "--stdio" },
		filetypes = {
			"html",
			"typescriptreact",
			"javascriptreact",
			"css",
			"sass",
			"scss",
			"less",
			"svelte",
		},
		root_markers = { "package.json" },
	},
}
