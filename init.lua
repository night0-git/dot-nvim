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

-- Prevent accidental quit on last window: :q! will not quit (transformed to
-- :e!) when there is only 1 window and there are unsaved changes in the buffer.
vim.cmd([[
  cabbrev q! <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? (winnr('$') == 1 ? (&modified ? 'e!' : 'q!') : 'q!') : 'q!')<CR>
]])
