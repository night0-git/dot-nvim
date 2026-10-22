vim.api.nvim_create_user_command("SetColorscheme", function(opts)
  local success, msg = require("theme_manager").set_and_save_colorscheme(opts.args)
  if not success then
    vim.notify("set_and_save_colorscheme: " .. msg, vim.log.levels.WARN)
  end
end, {
  nargs = 1,
  complete = function()
    local schemes = vim.fn.getcompletion("", "color")

    local seen = {}
    for _, s in ipairs(schemes) do
      seen[s] = true
    end

    -- Add without duplicating names.
    local function add(s)
      if not seen[s] then
        seen[s] = true
        table.insert(schemes, s)
      end
    end

    local specs = require("plugins.colorscheme")
    for _, spec in ipairs(specs) do
      -- Add variants manually added through the custom 'variants'
      -- field in the spec table.
      if spec.variants then
        for _, v in ipairs(spec.variants) do
          add(v)
        end
      end
    end

    return schemes
  end,
  desc = "Set active colorscheme and persist it to a text file",
})

vim.api.nvim_create_user_command("Q", function(opts)
  local bang = opts.bang and "!" or ""
  vim.cmd("bdelete" .. bang)
end, { bang = true })
