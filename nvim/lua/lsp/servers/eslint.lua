-- lsp/servers/eslint.lua
local markers = {
	".eslintrc",
	".eslintrc.json",
	".eslintrc.yaml",
	".eslintrc.yml",
	".eslintrc.js",
	".eslintrc.cjs",
	"eslint.config.js",
	"eslint.config.cjs",
	"eslint.config.mjs",
	"eslint.config.ts",
	"package.json",
}

local function find_root(fname)
	local start = fname and vim.fs.dirname(fname) or vim.fn.getcwd()
	local found = vim.fs.find(markers, { path = start, upward = true, type = "file" })[1]
	return found and vim.fs.dirname(found) or nil
end

return {
	"eslint",
	{
		cmd = { "vscode-eslint-language-server", "--stdio" },
		filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
		single_file_support = false, -- force a project
		-- IMPORTANT: give ESLint a concrete root so Neovim advertises workspaceFolders
		root_dir = function(bufnr)
			local name = vim.api.nvim_buf_get_name(bufnr)
			return find_root(name)
		end,
		-- Keep settings minimal; let the server infer the cwd from workspaceFolders/root_dir
		settings = {
			format = false,
			codeAction = {
				disableRuleComment = { enable = true },
				showDocumentation = { enable = true },
			},
		},
		-- Belt-and-suspenders: ensure the client exposes a workspace folder even if Neovim doesn’t.
		on_init = function(client)
			if (not client.workspace_folders or #client.workspace_folders == 0) and client.config.root_dir then
				client.workspace_folders = {
					{ name = client.config.root_dir, uri = vim.uri_from_fname(client.config.root_dir) },
				}
			end
		end,
	},
}
