return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    -- vim.opt.termguicolors = true -- This is done from global settings

    require("nvim-tree").setup({
      filters = {
        git_ignored = false,
      },
      renderer = {
        icons = {
          glyphs = {
            git = {
              untracked = "", -- default: "★",
            },
          },
        },
      },
    })
  end
}
