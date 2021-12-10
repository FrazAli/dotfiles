-- Themes
-- require('themes/material')
require('themes/nightfox')

-- Settings
require('keymaps')
require('settings')

-- Plugins with default or no config.
require('nvim-web-devicons').setup()
require('plenary')

-- Config. for plugins
require('plugins/lualine')
require('plugins/telescope')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')

-- Code Completion
require('plugins/nvim-cmp')
require('plugins/lsp_signature')
