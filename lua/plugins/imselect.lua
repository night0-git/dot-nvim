local is_windows = vim.fn.has("win32") == 1

return {
  "keaising/im-select.nvim",
  opts = {
    default_command = is_windows and "im-select" or "fcitx5-remote",
    default_im_select = is_windows and "1033" or "keyboard-us",
  },
}
