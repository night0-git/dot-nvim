local treesitter_indent = {
    python = true,
}

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")

        ts.setup()

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(event)
                local ft = event.match
                local lang = vim.treesitter.language.get_lang(ft)

                if not lang or not vim.list_contains(ts.get_available(), lang) then
                    return
                end

                -- Enable indenting (experimental).
                if treesitter_indent[ft] then
                    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end

                -- For installed parsers this will finishe instantly.
                ts.install({ lang }):await(function()
                    if vim.api.nvim_buf_is_valid(event.buf) then
                        vim.treesitter.start(event.buf, lang)
                    end
                end)
            end,
        })
    end,
}
