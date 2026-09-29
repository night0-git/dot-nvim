local augroup = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Recalculate floating windows on resize",
    group = augroup,
    callback = function()
        -- Check if the current buffer is an Oil buffer.
        if vim.bo.filetype == "oil" then
            require("oil").close()
            require("oil").open_float()
        end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP keymaps",
    group = augroup,
    callback = function(event)
        local opts = {
            nowait = true,
            buffer = event.buf,
        }
        local map = require("config.keymaps").map
        local lsp = vim.lsp

        map("n", "H", function()
            lsp.buf.hover()
        end, "LSP hover documentation", opts)
        map("n", "gd", function()
            require("fzf-lua").lsp_definitions()
        end, "LSP definitions", opts)
        map("n", "gD", function()
            require("fzf-lua").lsp_declarations()
        end, "LSP declarations", opts)
        map("n", "ga", function()
            require("fzf-lua").lsp_code_actions({
                filter = function(action)
                    return action.edit ~= nil or action.command ~= nil
                end,
                silent = true,
            })
        end, "LSP code actions", opts)
        map("n", "gr", function()
            require("fzf-lua").lsp_references()
        end, "LSP references", opts)
        map("n", "<leader>fd", function()
            require("fzf-lua").lsp_workspace_diagnostics()
        end, "LSP diagnostics", opts)
        map("n", "<leader>fD", function()
            require("fzf-lua").lsp_document_diagnostics()
        end, "LSP buffer diagnostics", opts)

        map("n", "<leader>uh", function()
            lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled())
        end, "Toggle inlay hint", opts)
    end,
})

-- Track fish bind mode and interactive TUI per terminal buffer.
vim.api.nvim_create_autocmd("TermRequest", {
    desc = "Track shell bind mode via OSC sequences",
    group = augroup,
    callback = function(args)
        -- In neovim, args.data is either the raw string itself or a table
        -- containing { sequence = "..." }.
        local seq = type(args.data) == "table" and (args.data.sequence or args.data.request) or args.data
        if type(seq) ~= "string" then
            return
        end

        local mode = seq:match("fish_mode;([%w_-]+)")
        if mode then
            vim.b[args.buf].shell_mode = mode
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
    desc = "Auto fold Obsidian's frontmatter",
    group = augroup,
    pattern = "*.md",
    callback = function(args)
        -- UFO loads asynchronously so we delay the execution.
        vim.defer_fn(function()
            if not vim.api.nvim_buf_is_valid(args.buf) then
                return
            end

            local first_line = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1]
            if first_line == "---" then
                pcall(vim.cmd, "1,1foldclose")
            end
        end, 100)
    end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    desc = "Ensure floating window highlights are consistent across themes",
    group = augroup,
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        local float = vim.api.nvim_get_hl(0, { name = "NormalFloat" })

        -- If NormalFloat bg is undefined, inherit from Normal.
        if not float.bg then
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = normal.bg })
        end

        -- If FloatBorder fg is undefined, use Comment color for a subtle
        -- border.
        local border = vim.api.nvim_get_hl(0, { name = "FloatBorder" })
        if not border.fg then
            vim.api.nvim_set_hl(0, "FloatBorder", {
                fg = vim.api.nvim_get_hl(0, { name = "Comment" }).fg,
            })
        end
    end,
})
