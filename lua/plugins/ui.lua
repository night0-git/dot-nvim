return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        globalstatus = true,
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_x = {},
        lualine_y = { "encoding", "fileformat", "filetype" },
      },
      extensions = { "lazy", "oil" },
    },
  },

  -- {
  --     "https://github.com/akinsho/bufferline.nvim",
  --     dependencies = "nvim-tree/nvim-web-devicons",
  --     lazy = false,
  --     opts = {
  --         options = {
  --             mode = "tabs",
  --             show_buffer_icons = false,
  --             show_buffer_close_icons = false,
  --             offsets = {
  --                 {
  --                     filetype = "oil",
  --                     text = "File Explorer",
  --                     text_align = "center",
  --                     separator = true,
  --                 },
  --             },
  --         },
  --     },
  --     keys = {
  --         { "<C-n>", "<cmd>BufferLineCycleNext<cr>", desc = "Cycle to next buffer" },
  --         { "<C-p>", "<cmd>BufferLineCyclePrev<cr>", desc = "Cycle to previous buffer" },
  --     }
  -- },

  {
    "Bekaboo/dropbar.nvim",
    lazy = false,
    opts = function(_, opts)
      local default_enable = require("dropbar.configs").opts.bar.enable

      opts.bar = opts.bar or {}
      opts.bar.enable = function(buf, win, info)
        if vim.bo[buf].buftype == "terminal" or vim.fn.bufname(buf):match("^term://") then
          return false
        end
        return default_enable(buf, win, info)
      end
    end,
    keys = {
      {
        "<leader>;",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Pick symbols in winbar",
      },
      {
        "[;",
        function()
          require("dropbar.api").goto_context_start()
        end,
        desc = "Go to start of current context",
      },
      {
        "];",
        function()
          require("dropbar.api").select_next_context()
        end,
        desc = "Select next context",
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      win = { border = "rounded" },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "kevinhwang91/nvim-hlslens",
    opts = {},
  },

  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      disabled_filetypes = {
        "help",
        "text",
        "markdown",
        "lazy",
        "mason",
        "checkhealth",
        "lspinfo",
        "trouble",
        "qf",
      },
      custom_colorcolumn = function()
        return tostring(vim.bo.textwidth > 0 and vim.bo.textwidth or 80)
      end,
    },
  },
}
