-- use space as <leader> key
vim.g.mapleader = " "

-- vim.opt.correct lang to make copy to clipboard utf-8
vim.cmd[[
    lang en_US.UTF-8
    syntax on
    filetype plugin indent on
]]

vim.opt.encoding = 'utf-8'
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.regexpengine = 1

-- relative numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- more space for displaying messages
vim.opt.cmdheight = 2

-- indent with 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- hightlight active line
vim.opt.cursorline = true

-- hide mouse
vim.opt.mouse = nil

-- searching
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- integrate vim clipboard with system clipboard
vim.opt.clipboard:append('unnamedplus')

-- display title of current file in terminal title bar
vim.opt.title = true

-- allow hidden buffers
vim.opt.hidden = true

-- disable beeping
vim.opt.errorbells = false

-- dont wrap long lines
vim.opt.wrap = false

-- dont use swapfiles
vim.opt.swapfile = false

-- disable backups
vim.opt.backup = false
vim.opt.writebackup = false

-- start scrolling when 8 lines left
vim.opt.scrolloff = 8

-- always show the sign column
vim.opt.signcolumn = 'yes'

-- new splits are added to bottom or right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- avoid delays when typing
vim.opt.updatetime = 50

vim.opt.pyx = 3

-- display colorcolumn at 110 characters
vim.opt.colorcolumn = '115'

-- color column color
vim.cmd('highlight ColorColumn ctermbg=darkgray')

-- Always show status line
vim.opt.laststatus = 2

-- Format status line to show current file
vim.opt.statusline = ' %f'

-- enable folding
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = true
vim.opt.foldlevel = 10
vim.opt.foldnestmax = 10

vim.opt.completeopt = "menuone,noselect"


-- Make background transparent
vim.cmd [[
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
    highlight Normal guibg=none
    highlight NonText guibg=none
]]

-- Make comments use italic
vim.api.nvim_set_hl(0, 'Comment', { cterm = { italic = true }})
