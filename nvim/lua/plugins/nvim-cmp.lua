local kind_icons = {
  Text = "",
  Method = "",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = ""
}

local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' },                -- For vsnip users.
    { name = 'luasnip' },                 -- For luasnip users.
    -- { name = 'ultisnips' },            -- For ultisnips users.
    -- { name = 'snippy' },               -- For snippy users.
  }, {
    { name = 'buffer' },                  -- Source for buffer completions.
    { name = 'path' },                    -- Source for path completions.
    { name = 'treesitter' },              -- Source for treesitter completions.
    { name = 'nvim_lua' },                -- Source for lua completions.
    { name = 'spell' },                   -- Source for spelling completions.
    { name = 'nvim_lsp_signature_help' }, -- Source signature help
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "﬘",
        nvim_lsp = "ﲳ",
	treesitter = "",
	spell = "暈",
        luasnip = "",
        nvim_lua = "",
      })[entry.source.name]
      return vim_item
    end,
    },
    experimental = {
      ghost_text = false,
    },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['cssls'].setup {
  capabilities = capabilities
}

require('lspconfig')['html'].setup {
  capabilities = capabilities
}

require('lspconfig')['pyright'].setup {
  capabilities = capabilities
}

require('lspconfig')['rust_analyzer'].setup {
  capabilities = capabilities
}

require('lspconfig')['tsserver'].setup {
  capabilities = capabilities,
}

