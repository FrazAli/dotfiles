return {
	"terraformls",
	{
		cmd = { "terraform-ls", "serve" },
		filetypes = { "terraform", "tf", "hcl" },
		root_markers = { ".terraform", "terraform.tfvars" },
	},
}
