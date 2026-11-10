return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = { "copilotlsp-nvim/copilot-lsp" },
    event = "InsertEnter",
    opts = {
      suggestion = {
        auto_trigger = true,
      },
      nes = {
        enable = true,
        auto_trigger = true,
      },
    },
    config = function()
      local m = require("config.keymaps")
      m.map("i", "<Esc>", function()
        if not require("copilot-lsp.nes").clear() then
          m.feed_keys("<Esc>")
        end
      end, "Clear Copilot suggestion")
    end,
  },
}
