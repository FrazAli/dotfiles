local function keymap(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--TODO: check if keymap funciton implentaion can be merged with this.
local nmap = function (keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

keymap('', '<Space>', '<Nop>')
vim.g.mapleader = ' '

keymap('', '<F3>', ':NvimTreeToggle<CR>:NvimTreeRefresh<CR>')

-- Remove trailing space
keymap('n', '<Leader><Backspace>', [[ :%s/\s\+$//e <CR> ]])

-- Open terminal in a split
keymap('n', '<Leader>t', ":sp<CR> :term<CR> :resize 20N<CR> i")

-- Open diagnostic hint on current line in a floating window
keymap('n', '<Leader>h', ':lua vim.diagnostic.open_float()<CR>')

--LSP and code completions
nmap('gd', vim.lsp.buf.definition, '[G]oto [D]definition')
nmap('gi', vim.lsp.buf.definition, '[G]oto [I]mplementation')
nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
