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
require('lspconfig')
require('cmp')

-- Plugins with custom config.
require('plugins/telescope')
require('plugins/nvim-tree')
