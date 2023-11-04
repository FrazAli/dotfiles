-- Themes
-- require('themes/material')
require('themes/nightfox')            -- Dark theme

-- Settings
require('keymaps')                    -- General key maps
require('settings')                   -- Editor settings

-- Plugins with default or no config.
require('mason').setup()              -- Manages LSP servers and tools
require('nvim-ts-autotag').setup()    -- Auto-tags HTML using 'nvim-treesitter'
require('nvim-autopairs').setup()     -- Auto-pairs braces / brackets and more
require('nvim-web-devicons').setup()  -- Installs Nerd font symbols and icons
require('lspsaga').setup()            -- LSP completion front-end
require('plenary')                    -- Lua library needed by other plugins e.g. telescope

-- Plugins with custom config.
require('plugins/colorizer')          -- highlights color codes with the color
require('plugins/lualine')            -- Status line with symbols and theme
require('plugins/mason-lspconfig')    -- integrates 'mason' with 'nvim-lspconfig'
require('plugins/nvim-tree')          -- Side menu file browser
require('plugins/nvim-treesitter')    -- Tree-sitter support for many languages
require('plugins/prettier')           -- Helps prettify code formatting
require('plugins/telescope')          -- Fuzzy finder with preview

-- Code Completion
require('plugins/nvim-cmp')           -- Completion plugin
