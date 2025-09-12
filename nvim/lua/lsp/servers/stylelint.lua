return {
	"stylelint_lsp",
	{
		cmd = { "stylelint" },
		filetypes = { "css", "scss" },
		single_file_support = false,
		root_markers = {
			".stylelintrc",
			".stylelintrc.json",
			".stylelintrc.yaml",
			".stylelintrc.yml",
			".stylelintrc.js",
			".stylelintrc.cjs",
			"stylelint.config.js",
			"stylelint.config.cjs",
			"stylelint.config.mjs",
			"stylelint.config.ts",
			"package.json",
		},
		settings = { stylelintplus = {} },
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			require("lsp.config").on_attach(client, bufnr)
		end,
	},
}
