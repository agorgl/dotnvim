--
-- options
--

-- leader key
vim.g.mapleader = ","
-- local leader key
vim.g.maplocalleader = ","

-- show the line number in front of each line
vim.opt.number = true
-- when and how to display the sign column
vim.opt.signcolumn = "auto:1"

-- new window from split is below the current one
vim.opt.splitbelow = true
-- new window is put right of the current one
vim.opt.splitright = true

-- automatically detected end of line file formats
vim.opt.fileformats = { "unix", "dos" }
-- don't force eol in last line of file
vim.opt.fixendofline = false

-- don't use swapfiles for buffers
vim.opt.swapfile = false
-- don't keep backup file after overwriting a file
vim.opt.backup = false
-- don't make a backup before overwriting a file
vim.opt.writebackup = false

-- use spaces when tab is inserted
vim.opt.expandtab = true
-- number of columns between two tab stops
vim.opt.tabstop = 4
-- number of columns between two soft tab stops
vim.opt.softtabstop = 4
-- number of columns that make up one level of (auto)indentation
vim.opt.shiftwidth = 4
-- take indent for new line from previous line
vim.opt.autoindent = true
-- smart autoindenting when starting a new line
vim.opt.smartindent = true

-- long lines don't wrap and don't continue on the next line
vim.opt.wrap = false
-- wrap long lines at a blank
vim.opt.linebreak = true
-- wrapped line repeats indent
vim.opt.breakindent = true

-- options for insert mode completion
vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy", "nosort", "popup" }
-- maximum number of items to show in the popup menu
vim.opt.pumheight = 12
-- default border style of floating windows
vim.opt.winborder = "rounded"

-- enable 24-bit rgb color in the tui
vim.opt.termguicolors = true
-- enable mouse support
vim.opt.mouse = "a"

-- if this many milliseconds nothing is typed emit CursorHold autocommand event
vim.opt.updatetime = 300

-- sync clipboard between os and neovim
-- schedule the setting after `UIEnter` because it can increase startup-time
vim.api.nvim_create_autocmd("UIEnter", {
  group = vim.api.nvim_create_augroup("clipboard.setup", { clear = true }),
  callback = function()
    vim.opt.clipboard = "unnamedplus"
  end,
})

-- mail filetype specific options
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("filetype.mail", { clear = true }),
  pattern = "mail",
  callback = function()
    -- automatic formatting options
    vim.opt_local.formatoptions = "tcqjawl"
    -- show trailing spaces as '-'
    vim.opt_local.list = true
  end,
})
