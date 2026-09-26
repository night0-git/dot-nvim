return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
        },
    },

    {
        "martindur/zdiff.nvim",
        cmd = "Zdiff",
        keys = {
            { "<leader>zd", "<cmd>Zdiff<cr>", desc = "Zdiff (uncommitted)" },
            { "<leader>zD", "<cmd>Zdiff main<cr>", desc = "Zdiff (vs main)" },
        },
        opts = {},
    },
}
