-- Highlight trailing white space
vim.cmd([[ highlight ExtraWhitespace ctermbg=red guibg=red ]])
vim.cmd([[ match ExtraWhitespace /\s\+$/ ]])

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Set theme
-- vim.cmd("colorscheme catppuccin-mocha")

-- Pop-up menus and windows
vim.o.winborder = "rounded" -- Default border for all floating windows

-- Need these for Nerog, TODO: Investigate why ?
vim.wo.foldlevel = 99
-- This option helps conceal markdown
-- vim.wo.conceallevel = 2

-- Window splits
vim.o.splitbelow = true -- Default vertical split
vim.o.splitright = true -- Default horizontal split

-- General
vim.o.cursorline = true -- Highlight cursor line
vim.o.errorbells = false -- System bell on error
vim.o.scrolloff = 3 -- Number of lines offset for scrolling text
vim.o.showmode = false -- Show mode in the command line, lualine shows it instead
vim.o.showtabline = 2 -- When to show buffer tab line, 2 = always
vim.o.swapfile = true -- Enable swap file
vim.o.termguicolors = true -- 24-bit RGB color support

-- Spell checking
vim.o.spelllang = "en_us,sv" -- Languages for spell checking
vim.o.spell = true

-- Text wrap
vim.o.wrap = true -- Wrap text
vim.o.linebreak = true -- Break line only on characters in 'breakat'
vim.o.showbreak = "↳" -- Character to indicate broken line
vim.o.breakindent = true -- wrapped lines respect indentation

-- Line numbers in gutter
vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.numberwidth = 4
vim.wo.signcolumn = "yes" -- Column to show signs e.g. For LSP and diagnostics

-- Tab and indentation
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Buffer search and highlight
vim.o.incsearch = true -- Incremental search
vim.o.hlsearch = false -- Highlight search
vim.o.ignorecase = true -- Case insensitive search
vim.o.smartcase = true -- Case insensitive search if all lowercase, case sensitive otherwise
vim.o.inccommand = "split" -- Shows substitute changes in a split pop-up

-- Clipboard
vim.o.clipboard = "unnamedplus" -- Use system clipboard

-- Save undo history
vim.o.undofile = true

-- Enable completion pop ups
-- vim.o.completeopt="menu,menuone,preview,noinsert,noselect"

-- Set list mode characters
vim.opt.listchars = {
	tab = "->",
	lead = ".",
	trail = ".",
	nbsp = "+",
	eol = "↵",
}

-- Set fill chars (replace eob characters i.e. ~)
vim.opt.fillchars = {
	eob = " ",
}
