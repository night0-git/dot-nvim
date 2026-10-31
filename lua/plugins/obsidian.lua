local sysname = vim.uv.os_uname().sysname
local obsidian_path
if sysname == "Linux" then
  obsidian_path = "/home/night0/Documents/Obsidian"
elseif sysname == "Windows" then
  obsidian_path = "/home/night0/Documents/Obsidian"
else
  obsidian_path = "/home/night0/Documents/Obsidian"
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  -- Only load this plugin when in the Obsidian vault, otherwise we load it by
  -- one of the keymaps below.
  event = {
    "BufReadPre " .. obsidian_path .. "/**.md",
    "BufNewFile " .. obsidian_path .. "/**.md",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    picker = {
      name = "snacks.picker",
    },
    workspaces = {
      {
        name = "personal",
        path = obsidian_path,
      },
    },
    note_id_func = function(title)
      if title ~= nil then
        return (title:gsub('[\\/:*?"<>|]', ""))
      else
        return tostring(os.time())
      end
    end,
    ui = { enable = false }, -- avoid conflict with render-markdown
  },
  keys = {
    { "<leader>bb", "<cmd>Obsidian<CR>", desc = "Obsidian menu" },
    { "<leader>bw", "<cmd>Obsidian workspace<CR>", desc = "Obsidian workspaces" },
    { "<leader>bn", "<cmd>Obsidian new<CR>", desc = "Obsidian new" },
    { "<leader>bt", "<cmd>Obsidian today<CR>", desc = "Obsidian today" },
    { "<leader>by", "<cmd>Obsidian yesterday<CR>", desc = "Obsidian yesterday" },
    { "<leader>bf", "<cmd>Obsidian quick_switch<CR>", desc = "Obsidian files" },
    { "<leader>br", "<cmd>Obsidian search<CR>", desc = "Obsidian grep" },
  },
  path = obsidian_path,
}
