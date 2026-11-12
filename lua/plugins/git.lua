return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  opts = {
    base = "HEAD",
    current_line_blame = true,
  },
  keys = {
    { "]c", "<cmd>Gitsigns next_hunk<CR>", desc = "Next hunk" },
    { "[c", "<cmd>Gitsigns prev_hunk<CR>", desc = "Previous hunk" },
    { "<leader>hp", "<cmd>Gitsigns preview_hunk_inline<CR>", desc = "Preview hunk" },
  },
}
