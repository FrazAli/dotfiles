require("mason-lspconfig").setup({
	ensure_installed = {
		"cssls",
		"html",
		"lua_ls",
		"matlab_ls",
		"pyright",
		"rust_analyzer",
		"tsserver",
	},
	automatic_installation = true,
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig")["cssls"].setup({
	capabilities = capabilities,
})

require("lspconfig")["html"].setup({
	capabilities = capabilities,
})

require("lspconfig")["lua_ls"].setup({
	capabilities = capabilities,
})

require("lspconfig")["matlab_ls"].setup({
	capabilities = capabilities,
})

require("lspconfig")["pyright"].setup({
	capabilities = capabilities,
})

require("lspconfig")["rust_analyzer"].setup({
	capabilities = capabilities,
})

require("lspconfig")["tsserver"].setup({
	capabilities = capabilities,
})

require("lspconfig")["emmet_language_server"].setup({
	capabilities = capabilities,
})
