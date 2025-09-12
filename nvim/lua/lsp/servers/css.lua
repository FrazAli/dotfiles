return {
	"cssls",
	{
		cmd = { "vscode-css-language-server", "--stdio" },
		filetypes = { "css", "scss", "less" },
		root_markers = { "package.json" },
		settings = {
			css = {
				validate = true,
				lint = { unknownAtRules = "ignore" },
			},
		},
	},
}
