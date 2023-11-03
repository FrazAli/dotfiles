require('mason-lspconfig').setup({
  ensure_installed = {
    'cssls',
    'html',
    'lua_ls',
    'matlab_ls',
    'pyright',
    'rust_analyzer',
    'tsserver'
  },
  automatic_installation = true,
})
