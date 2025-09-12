return {
	"gopls",
	{
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_markers = { "go.work", "go.mod", ".git" },
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				gofumpt = true,
				analyses = { unusedparams = true },
			},
		},
	},
}
