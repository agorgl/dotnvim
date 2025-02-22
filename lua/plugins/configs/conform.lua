local M = {}

function M.config()
  local conform = require("conform")

  vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      -- FormatDisable! will disable formatting just for this buffer
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = "Disable autoformat-on-save",
    bang = true,
  })
  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = "Re-enable autoformat-on-save",
  })

  local opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      c = { "clang-format" },
    },
    formatters = {
      ["clang-format"] = {
        prepend_args = function()
          local clang_format_config = ".clang-format"
          if vim.fs.root(0, clang_format_config) then
            return nil
          end
          local config = vim.api.nvim_get_runtime_file(vim.fs.joinpath("data", clang_format_config), false)[1]

          local style_arg = string.format("--style=file:%s", config)
          return { style_arg }
        end,
      },
    },
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      local fmt_opts = {
        timeout_ms = 500,
        lsp_format = "fallback",
      }
      return fmt_opts
    end,
  }
  conform.setup(opts)
end

return M
