local function is_obsidian_buffer()
    local file_name = vim.api.nvim_buf_get_name(0)
    local obsidian_path = require("plugins.obsidian").path
    return string.find(file_name, obsidian_path, 1, true) ~= nil
end

return {
    {
        "folke/snacks.nvim",
        ---@type snacks.Config
        opts = {
            image = {},
        },
    },

    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
            default = {
                dir_path = function()
                    return is_obsidian_buffer() and "Attachments" or "assets"
                end,
                extension = function()
                    return is_obsidian_buffer() and "webp" or "png"
                end,
                process_cmd = function()
                    return is_obsidian_buffer() and "magick - -quality 85 webp:-" or ""
                end,
                prompt_for_file_name = false,
            },
        },
        keys = {
            { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
        },
    },
}
