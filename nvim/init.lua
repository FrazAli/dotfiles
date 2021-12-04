-- Themes
require('themes/nightfox')

-- Settings
require('keymaps')
require('settings')

-- Plugins with default or no config.
require('lualine').setup()
require('nvim-treesitter').setup()
require('nvim-web-devicons').setup()
require('plenary')

-- Plugins with custom config.
require('plugins/telescope')
require('plugins/nvim-tree')

-- Code Completion
require('plugins/nvim-cmp')
