return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
        current_line_blame = true,
    },
    keys = {
        { "]c", "<cmd>Gitsigns next_hunk<CR>", desc = "Next hunk" },
        { "[c", "<cmd>Gitsigns next_hunk<CR>", desc = "Previous hunk" },
        { "<leader>hp", "<cmd>Gitsigns preview_hunk_inline<CR>", desc = "Preview hunk" },
    },
}
