-- -- Settings
require("keymaps") -- General key maps
require("settings") -- Editor settings

-- Plugin Manager
require("plugins/manager/lazy")

-- Commands
vim.api.nvim_create_user_command("InsertWeather", require("utils").insert_weather, {})
