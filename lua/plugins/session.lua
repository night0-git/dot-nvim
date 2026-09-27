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
        bypass_save_filetypes = { "alpha" },
    },
}
