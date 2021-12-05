-- Themes
require('themes/nightfox')

-- Settings
require('keymaps')
require('settings')

-- Plugins with default or no config.
require('lualine').setup()
require('nvim-web-devicons').setup()
require('plenary')

-- Config. for plugins
require('plugins/telescope')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')

-- Code Completion
require('plugins/nvim-cmp')
