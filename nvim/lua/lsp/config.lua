-- Native LSP setup with auto-loading per-server files

local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- nvim-cmp capabilities
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Shared on_attach with keymaps
local function on_attach(_, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }
	local keymap = vim.keymap

	opts.desc = "Show LSP references"
	keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

	opts.desc = "Go to declaration"
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

	opts.desc = "Show LSP definitions"
	keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

	opts.desc = "Show LSP implementations"
	keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

	opts.desc = "Show LSP type definitions"
	keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

	opts.desc = "See available code actions"
	keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)

	opts.desc = "Smart rename"
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	opts.desc = "Show buffer diagnostics"
	keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

	opts.desc = "Show line diagnostics"
	keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

	opts.desc = "Show documentation for what is under cursor"
	keymap.set("n", "K", vim.lsp.buf.hover, opts)
end

-- Diagnostics UI
local s = vim.diagnostic.severity
vim.diagnostic.config({
	float = {
		source = true, -- always show source of diagnostics
	},
	signs = {
		text = {
			[s.ERROR] = " ",
			[s.WARN] = " ",
			[s.HINT] = "󰰁 ",
			[s.INFO] = " ",
		},
		-- optional: line number column (gutter) highlighting
		numhl = {
			[s.ERROR] = "DiagnosticSignError",
			[s.WARN] = "DiagnosticSignWarn",
			[s.HINT] = "DiagnosticSignHint",
			[s.INFO] = "DiagnosticSignInfo",
		},
		-- you can also set linehl if you like:
		-- linehl = {
		--   [s.ERROR] = "DiagnosticLineError",
		--   [s.WARN]  = "DiagnosticLineWarn",
		--   [s.HINT]  = "DiagnosticLineHint",
		--   [s.INFO]  = "DiagnosticLineInfo",
		-- },
	},
})

-- load all server modules and enable them
local servers_dir = vim.fn.stdpath("config") .. "/lua/lsp/servers"
for fname, ftype in vim.fs.dir(servers_dir) do
	if ftype == "file" and fname:sub(-4) == ".lua" then
		local modv = require("lsp.servers." .. fname:sub(1, -5))

		local items
		if type(modv) == "table" and type(modv[1]) == "string" and type(modv[2]) == "table" then
			items = { modv } -- single {name,cfg}
		elseif type(modv) == "table" and type(modv[1]) == "table" then
			items = modv -- list of {name,cfg}
		else
			error("Invalid server module shape: " .. fname)
		end

		local function register(name, cfg)
			local final = vim.tbl_deep_extend("force", {
				capabilities = capabilities,
				on_attach = on_attach,
			}, cfg or {})
			vim.lsp.config[name] = final
			vim.lsp.enable(name)
		end

		for _, pair in ipairs(items) do
			register(pair[1], pair[2])
		end
	end
end
