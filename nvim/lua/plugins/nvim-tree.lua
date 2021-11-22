vim.g.nvim_tree_icons = {
default = '',
symlink = '',
git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "", -- default: "★",
    deleted = "",
    ignored = "◌"
  },
folder = {
    arrow_open = "",
    arrow_closed = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  }
}

require('nvim-tree').setup()
