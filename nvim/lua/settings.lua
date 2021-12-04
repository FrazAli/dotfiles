-- Highlight trailing white space
vim.cmd([[ highlight ExtraWhitespace ctermbg=red guibg=red ]])
vim.cmd([[ match ExtraWhitespace /\s\+$/ ]])

-- Line numers
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.numberwidth = 4
-- vim.wo.signcolumn = number

-- Enable completion pop ups
vim.o.completeopt="menu,menuone,noinsert,noselect"

