return {
  {
    "dmtrKovalenko/fff",
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    opts = {
      wrap_around = true,
      prompt = "> ",
      keymaps = {
        move_up = { "<Up>", "<C-k>" },
        move_down = { "<Down>", "<C-j>" },
      },
      layout = {
        prompt_position = "top",
      },
    },
    lazy = false,
    keys = {
      {
        "<leader>ff",
        function()
          require("fff").find_files()
        end,
        desc = "FFFind files",
      },
      {
        "<leader>fr",
        function()
          require("fff").live_grep()
        end,
        desc = "LiFFFe grep",
      },
    },
  },
}
