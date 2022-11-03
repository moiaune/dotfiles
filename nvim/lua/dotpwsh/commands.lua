-- you might have to force true color when using regular vim inside tmux as the
-- colorscheme can appear to be grayscale with "termguicolors" option enabled.
vim.cmd[[
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
]]

-- reload file if changes from outside
vim.cmd("au FocusGained,BufEnter * :checktime")

-- avoid human error
vim.cmd("command! W w")
