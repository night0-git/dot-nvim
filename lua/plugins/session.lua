return {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
        { "<leader>ss", "<cmd>AutoSession search<CR>",       desc = "Session search" },
        { "<leader>sd", "<cmd>AutoSession deletePicker<CR>", desc = "Session delete" },
    },

    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        cwd_change_handling = true,
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        bypass_save_filetypes = { "alpha" },
        -- Close oil buffers before saving to prevent corrupted `oil://` buffer
        -- paths (cause may be some kind of race condition).
        pre_save_cmds = {
            function()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.bo[buf].filetype == "oil" then
                        vim.api.nvim_buf_delete(buf, { force = true })
                    end
                end
            end,
        },
    },
}
