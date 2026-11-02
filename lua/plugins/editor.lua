return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},

    -- The three "core" operations of add/delete/change can be done with the keymaps
    -- ys{motion}{char}, ds{char}, and cs{target}{replacement}, respectively. For the
    -- following examples, * will denote the cursor position:
    --
    --  Old text                    Command    New text
    -- ----------------------------------------------------------------
    --  surr*ound_words             ysiw)      (surround_words)
    --  surr*ound_words             ysiw(      ( surround_words )
    --  *make strings               ys$"       "make strings"
    --  [delete ar*ound me!]        ds]        delete around me!
    --  remove <b>HTML t*ags</b>    dst        remove HTML tags
    --  'change quot*es'            cs'"       "change quotes"
    --  <b>or tag* types</b>        csth1<CR>  <h1>or tag types</h1>
    --  delete(functi*on calls)     dsf        function calls
    --
    --  Detailed: <:h nvim-surround.usage>
  },

  {
    "sindrets/winshift.nvim",
    opts = {
      keymaps = {
        disable_defaults = true,
      },
    },
    keys = {
      { "<C-M-Up>", "<cmd>WinShift up<cr>", desc = "Move window up" },
      { "<C-M-Down>", "<cmd>WinShift down<cr>", desc = "Move window down" },
      { "<C-M-Left>", "<cmd>WinShift left<cr>", desc = "Move window left" },
      { "<C-M-Right>", "<cmd>WinShift right<cr>", desc = "Move window right" },
      { "<C-M-s>", "<cmd>WinShift swap<cr>", desc = "Swap window" },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    lazy = false, -- lazy-load causes a lot of errors
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
    config = function(_, opts)
      vim.opt.foldcolumn = "0"
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true

      require("ufo").setup(opts)
    end,
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
    },
  },

  {
    "abecodes/tabout.nvim",
    opts = {},
  },

  {
    "chrisgrieser/nvim-chainsaw",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>ll",
        function()
          require("chainsaw").variableLog()
        end,
        desc = "Log variable",
      },
      {
        "<leader>lo",
        function()
          require("chainsaw").objectLog()
        end,
        desc = "Log object",
      },
      {
        "<leader>lt",
        function()
          require("chainsaw").typeLog()
        end,
        desc = "Log type",
      },
      {
        "<leader>la",
        function()
          require("chainsaw").assertLog()
        end,
        desc = "Log assertion",
      },
      {
        "<leader>lm",
        function()
          require("chainsaw").messageLog()
        end,
        desc = "Log message",
      },
      {
        "<leader>ld",
        function()
          require("chainsaw").debugLog()
        end,
        desc = "Debug statement",
      },
      {
        "<leader>lr",
        function()
          require("chainsaw").removeLogs()
        end,
        desc = "Remove logs",
      },
    },
  },

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      { "zj", "<cmd>TSJToggle<cr>", desc = "Join or split code block" },
    },
  },

  {
    "folke/trouble.nvim",
    opts = {
      focus = true,
      win = {
        size = 20,
      },
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },

  {
    "NMAC427/guess-indent.nvim",
    opts = {},
  },
}
