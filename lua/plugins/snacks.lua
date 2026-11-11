return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    image = { enabled = true },
    quickfile = { enabled = true },
    notifier = { enabled = true },
    rename = { enabled = true },
    indent = {
      enabled = true,
      indent = { -- show subtle indentation levels
        enabled = false,
      },
      animate = {
        enabled = false,
      },
      scope = { -- highlights current scope
        enabled = true,
        hl = "SnacksIndent",
      },
    },
    scope = {
      enabled = true,
      cursor = false,
    },
    terminal = { enabled = true },
    gitbrowse = { enabled = true },
    bufdelete = { enabled = true },
  },

  keys = {
    -- Buffer management
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete buffer",
    },

    -- Git & Terminal
    {
      "<leader>go",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Open in browser (git)",
    },
    {
      "<C-/>",
      function()
        Snacks.terminal()
      end,
      desc = "Toggle Terminal",
    },
  },
}
