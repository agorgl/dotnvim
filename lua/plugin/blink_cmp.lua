--
-- plugin.blink_cmp
--

local M = {}

function M.build(_)
  local blink_cmp = require("blink.cmp")
  blink_cmp.build():pwait()
end

local function has_words_before()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  if col == 0 then
    return false
  end
  local line = vim.api.nvim_get_current_line()
  return line:sub(col, col):match("%s") == nil
end

function M.config()
  local blink_cmp = require("blink.cmp")
  blink_cmp.setup({
    keymap = {
      preset = "default",
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            if has_words_before() then
              return cmp.show_and_insert_or_accept_single()
            end
          end
        end,
        "select_next",
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    completion = {
      list = { selection = { preselect = false } },
      accept = { auto_brackets = { enabled = false } },
      documentation = { auto_show = true },
    },
    signature = { enabled = true },
  })
end

return M
