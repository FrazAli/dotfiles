-- Highlight trailing white space
vim.cmd([[ highlight ExtraWhitespace ctermbg=red guibg=red ]])
vim.cmd([[ match ExtraWhitespace /\s\+$/ ]])

-- Set theme
vim.cmd("colorscheme nightfox")

-- General
vim.o.scrolloff = 3           -- Number of lines offset for scrolling text
vim.o.errorbells = false      -- System bell on error
vim.o.termguicolors = true    -- 24-bit RGB color support
vim.o.showmode = false        -- Show mode in the command line
vim.o.showtabline = 2         -- When to show buffer tab line, 2 = always
vim.o.splitbelow = true       -- Default vertical split
vim.o.splitright = true       -- Default horizontal split
vim.o.swapfile = true         -- Enable swap file
vim.o.wrap = false            -- Wrap text
vim.o.colorcolumn = '120'     -- Column number to mark for recommended max. line length
vim.o.cursorline = true       -- Highlight cursol line


-- Line numers
vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.numberwidth = 4
vim.wo.signcolumn = 'yes'     -- Column to show signs e.g. for lsp and diagnostics

-- Tab and indentation
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Buffer search and highlight
vim.o.incsearch = true
vim.o.hlsearch = false
vim.o.ignorecase = true

-- Enable completion pop ups
vim.o.completeopt="menu,menuone,preview,noinsert,noselect"

-- Set list mode characters
vim.opt.listchars = {
  tab = '->',
  lead = '.',
  trail = '.',
  nbsp = '+',
  eol = '↵',
}

