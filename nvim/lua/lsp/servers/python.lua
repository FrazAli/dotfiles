-- Pyright: keep the diag-tag tweak you used before
local py_cap = vim.lsp.protocol.make_client_capabilities()
py_cap.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }

local pyright_cfg = {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	single_file_support = true,
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	capabilities = py_cap,
	settings = {
		pyright = { disableOrganizeImports = true }, -- Ruff will handle imports if you want
		python = {
			analysis = {
				-- pick your poison; remove overrides if you want full Pyright
				typeCheckingMode = "basic", -- "off" | "basic" | "standard" | "strict"
				diagnosticMode = "openFilesOnly", -- or "workspace"
				-- Uncomment to quiet Pyright where Ruff already warns:
				-- diagnosticSeverityOverrides = {
				--   reportUnusedImport   = "none",
				--   reportUnusedVariable = "none",
				-- },
			},
		},
	},
}

local ruff_cfg = {
	cmd = { "ruff", "server" }, -- Mason: ruff
	filetypes = { "python" },
	single_file_support = true,
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", "setup.cfg", "requirements.txt", ".git" },
	-- settings = {} -- defaults are fine
}

return {
	{ "pyright", pyright_cfg },
	{ "ruff", ruff_cfg },
}
