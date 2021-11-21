-- Themes
require('themes/nightfox')

-- Settings
require('keymaps')
require('settings')

-- Plugins
require('lualine').setup()
require('nvim-tree').setup()
require('nvim-treesitter').setup()
require('nvim-web-devicons').setup()
require('plenary')
require('lspconfig')
require('cmp')

-- Plugins with config.
require('plugins/telescope')
