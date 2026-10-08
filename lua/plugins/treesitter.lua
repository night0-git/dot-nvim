local parsers = {
    "lua",
    "c",
    "cpp",
    "rust",
    "python",
    "markdown",
    "markdown_inline",
    "yaml",
    "bash",
    "json",
    "toml",
    "make",
    "cmake",
    "dockerfile",
    "gitcommit",
    "gitignore",
    "html",
    "css",
    "javascript",
    "typescript",
    "latex",
}

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").setup()

        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = parsers,
            callback = function(event)
                -- Enable highlighting.
                vim.treesitter.start()

                -- Enable indenting.
                local treesitter_indent = {
                    python = true,
                }
                if treesitter_indent[event.match] then
                    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end,
}
