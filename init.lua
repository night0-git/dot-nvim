require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.usercmds")
require("config.lazy_help")

-- Active theme is loaded here by reading from a state file.
local success, msg = require("theme_manager").load_colorscheme()
if not success then
  vim.notify("load_colorscheme: " .. msg, vim.log.levels.WARN)
end
