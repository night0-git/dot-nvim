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
  },
}
