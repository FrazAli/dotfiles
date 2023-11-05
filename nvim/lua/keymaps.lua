local function keymap(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--TODO: check if keymap function implementation can be merged with this.
local nmap = function (keys, func, desc)
  if desc then
    desc = 'LSP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { desc = desc })
end

keymap('', '<Space>', '<Nop>')
vim.g.mapleader = ' '

keymap('', '<F3>', ':NvimTreeFindFileToggle!<CR>')

-- Remove trailing space
keymap('n', '<Leader><Backspace>', [[ :%s/\s\+$//e <CR> ]])

-- Open terminal in a split
keymap('n', '<Leader>t', ":sp<CR> :term<CR> :resize 20N<CR> i")

-- Open signature help on current line in a floating window

--LSP and code completions
nmap('gd', vim.lsp.buf.definition, '[G]oto [D]definition')
nmap('gi', vim.lsp.buf.definition, '[G]oto [I]mplementation')
nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

-- LSP Saga
keymap('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<cr>')
keymap('n', '<C-k>', '<Cmd>Lspsaga diagnostic_jump_prev<cr>')
keymap('n', '<C-h>', '<Cmd>Lspsaga show_cursor_diagnostics<cr>')
keymap('n', '<C-s>', '<Cmd>Lspsaga hover_doc<cr>')

-- TODO: Read up on these and keep ones that are useful
nmap('<Leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
nmap('<Leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
nmap('<Leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orspace [S]ymbols')
