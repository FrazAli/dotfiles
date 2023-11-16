-- Themes
-- require('themes/material')
-- require('themes/nightfox')            -- Dark theme
require('themes/catppuccin')          -- Pastel theme
-- require('themes/kanagawa')            -- Pastel theme based on painting by Katsushika Hokusai

-- Settings
require('keymaps')                    -- General key maps
require('settings')                   -- Editor settings

-- Plugins with default or no config.
require('nvim-ts-autotag').setup()    -- Auto-tags HTML using 'nvim-treesitter'
require('nvim-autopairs').setup()     -- Auto-pairs braces / brackets and more
require('nvim-web-devicons').setup()  -- Installs Nerd font symbols and icons
require('lspsaga').setup()            -- LSP completion front-end
require('plenary')                    -- Lua library needed by other plugins e.g. telescope

-- Plugins with custom config.
require('plugins/colorizer')          -- highlights color codes with the color
require('plugins/conform')            -- Auto-format on save
require('plugins/gitsigns')           -- Git integration
require('plugins/hologram')           -- Markdown image preview
require('plugins/image')              -- Ascii image preview
require('plugins/lualine')            -- Status line with symbols and theme
require('plugins/mason')              -- Manages LSP servers and tools
require('plugins/mason-lspconfig')    -- integrates 'mason' with 'nvim-lspconfig'
require('plugins/neorg')              -- Neorg for note taking
require('plugins/nvim-tree')          -- Side menu file browser
require('plugins/nvim-treesitter')    -- Tree-sitter support for many languages
require('plugins/prettier')           -- Helps prettify code formatting
require('plugins/telescope')          -- Fuzzy finder with preview

-- Code Completion
require('plugins/nvim-cmp')           -- Completion plugin
