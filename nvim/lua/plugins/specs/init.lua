-- Plugins with default or no config.
return {
  {
    "windwp/nvim-autopairs", -- Auto-pairs braces / brackets and more
    event = "InsertEnter",
    opts = {},  -- invokes setup({}) with default config.
  },
  "nvim-lua/plenary.nvim", -- Lua library needed by other plugins e.g. telescope
}

