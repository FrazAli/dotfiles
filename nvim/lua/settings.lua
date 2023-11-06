-- Highlight trailing white space
vim.cmd([[ highlight ExtraWhitespace ctermbg=red guibg=red ]])
vim.cmd([[ match ExtraWhitespace /\s\+$/ ]])

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Set theme
vim.cmd("colorscheme catppuccin-mocha")

-- General
vim.o.scrolloff = 3           -- Number of lines offset for scrolling text
vim.o.errorbells = false      -- System bell on error
vim.o.termguicolors = true    -- 24-bit RGB color support
vim.o.showmode = false        -- Show mode in the command line, lualine shows it instead
vim.o.showtabline = 2         -- When to show buffer tab line, 2 = always
vim.o.splitbelow = true       -- Default vertical split
vim.o.splitright = true       -- Default horizontal split
vim.o.swapfile = true         -- Enable swap file
vim.o.colorcolumn = '120'     -- Column number to mark for recommended max line length
vim.o.cursorline = true       -- Highlight cursor line

-- Spell checking
vim.o.spelllang = 'en_us'     -- Languages for spell checking
vim.o.spell = true

-- Text wrap
vim.o.wrap = true             -- Wrap text
vim.o.linebreak = true        -- Break line only on characters in 'breakat'
vim.o.showbreak = '↳'         -- Character to indicate broken line

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.numberwidth = 4
vim.wo.signcolumn = 'yes'     -- Column to show signs e.g. For LSP and diagnostics


-- Tab and indentation
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.breakindent = true      -- wrapped lines respect indentation

-- Buffer search and highlight
vim.o.incsearch = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.inccommand = 'split'    -- Shows substitute changes in a split pop-up

-- Enable completion pop ups
-- vim.o.completeopt="menu,menuone,preview,noinsert,noselect"
vim.o.pumblend = 5            -- Pop-up menu transparency, values: 0-30, 100

-- Set list mode characters
vim.opt.listchars = {
  tab = '->',
  lead = '.',
  trail = '.',
  nbsp = '+',
  eol = '↵',
}

