return {
    "https://github.com/mfussenegger/nvim-dap",
    dependencies = {
        "igorlfs/nvim-dap-view",
        "thehamsta/nvim-dap-virtual-text",
    },
    keys = {
        { "<leader>dt", "<cmd>DapViewToggle<cr>" },
        { "<leader>db", "<cmd>DapToggleBreakpoint<cr>" },
        { "<leader>dc", "<cmd>DapContinue<cr>" },
        { "<leader>dw", "<cmd>DapViewWatch<cr>" },
    },
}
