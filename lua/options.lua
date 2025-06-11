local options = {
  opt = {
    fileencoding = "utf-8", -- file content encoding for the buffer
    fileformats = { "unix", "dos" }, -- end of line formats for the buffer
    wrap = false, -- disable wrapping of lines longer than the width of window
    number = true, -- show line numbers
    mouse = "a", -- enable mouse support
    clipboard = "unnamedplus", -- connection to the system clipboard
    swapfile = false, -- disable use of swapfile for the buffer
    backup = false, -- disable making a backup file
    writebackup = false, -- disable making a backup before overwriting a file
    expandtab = true, -- enable the use of spaces in tab
    smartindent = true, -- do auto indenting when starting a new line
    shiftwidth = 4, -- number of spaces inserted for indentation
    tabstop = 4, -- number of spaces in a tab
    splitbelow = true, -- splitting a new window below the current one
    splitright = true, -- splitting a new window at the right of the current one
    fixendofline = false, -- do not restore eol in end of file if missing
    termguicolors = true, -- enable 24-bit RGB color in the TUI
    pumheight = 12, -- height of the pop up menu
    completeopt = { "menu", "menuone", "noselect" }, -- options for insert mode completion
    timeoutlen = 1000, -- length of time to wait for a mapped sequence
    updatetime = 300, -- length of time to wait before triggering the plugin
    signcolumn = "auto:1", -- when and how to draw the signcolumn
  },
  g = {
    mapleader = ",", -- leader key
    maplocalleader = ",", -- local leader key
  },
}

for scope, tbl in pairs(options) do
  for k, v in pairs(tbl) do
    vim[scope][k] = v
  end
end

local filetype_options = {
  mail = {
    formatoptions = "tcqjawl", -- automatic formatting options
    list = true, -- show trailing spaces as '-'
  },
}

for ft, tbl in pairs(filetype_options) do
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup(ft .. "_filetype", { clear = true }),
    pattern = ft,
    callback = function()
      for k, v in pairs(tbl) do
        vim.opt_local[k] = v
      end
    end,
  })
end
