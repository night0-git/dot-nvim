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

    picker = {
      enabled = true,
      ui_select = true,
      layout = {
        preset = "telescope",
      },
      sources = {
        colorschemes = {
          confirm = function(picker, item)
            picker:close()
            if item then
              picker.preview.state.colorscheme = nil
              vim.schedule(function()
                vim.cmd("SetColorscheme " .. item.text)
              end)
            end
          end,
        },
      },
    },
  },

  keys = {
    -- Pickers
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.grep()
      end,
      desc = "Live grep",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Find git files",
    },
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Find colorschemes",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Find projects",
    },

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
