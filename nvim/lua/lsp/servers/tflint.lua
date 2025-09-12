return {
	"tflint",
	{
		cmd = { "tflint", "--langserver" }, -- Mason: tflint
		filetypes = { "terraform", "tf" },
		single_file_support = false,
		root_markers = { ".tflint.hcl" },
	},
}
