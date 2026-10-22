return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    { "<leader>ss", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>sd", "<cmd>AutoSession deletePicker<CR>", desc = "Session delete" },
  },

  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    cwd_change_handling = true,
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    bypass_save_filetypes = { "alpha", "oil" },
    -- Explicitly open any startup buffer here to ensure that they never
    -- interfere with restored buffers.
    no_restore_cmds = {
      function()
        if vim.fn.argc() ~= 0 then
          local first_arg = vim.fn.argv(0)
          if type(first_arg) == "string" and vim.fn.isdirectory(first_arg) == 1 then
            require("oil").open()
          end
        else
          require("alpha").start(true, require("alpha").my_config)
        end
      end,
    },
  },
}
