-- Themes
-- require('themes/material')
require('themes/nightfox')

-- Settings
require('keymaps')
require('settings')

-- Plugins with default or no config.
require('nvim-ts-autotag').setup()
require('nvim-autopairs').setup()
require('nvim-web-devicons').setup()
require('lspsaga').setup()
require('plenary')

-- Plugins with custom config.
require('plugins/colorizer')
require('plugins/lualine')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')
require('plugins/prettier')
require('plugins/telescope')

-- Code Completion
require('plugins/nvim-cmp')
