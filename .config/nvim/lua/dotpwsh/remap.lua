local nmap = require('dotpwsh.keymap').nmap
local vmap = require('dotpwsh.keymap').vmap
local nnoremap = require('dotpwsh.keymap').nnoremap
local inoremap = require('dotpwsh.keymap').inoremap
local vnoremap = require('dotpwsh.keymap').vnoremap

-- open netwrt
nnoremap("<leader>pv", vim.cmd.Ex)

nnoremap("<leader>b", vim.cmd.Buffers)

nmap("<C-a>", "<C-o>")

-- move visual line(s) up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move lines up/down
nnoremap("<S-Up>", "<cmd>m-2<CR>")
nnoremap("<S-Down>", "<cmd>m+1<CR>")
inoremap("<S-Up>", "<Esc><cmd>m-2<CR>")
inoremap("<S-Down>", "<Esc><cmd>m+1<CR>")

-- keeps search in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- keeps half page up and down in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- deletes highlighted word/line into void and keeps the pasted value
-- in default register so you can paste many times
vim.keymap.set("x", "<leader>p", "\"_dP")

-- delete to void
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- search and replace
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- switching between windows
nnoremap("<leader>h", "<cmd>wincmd h<CR>")
nnoremap("<leader>j", "<cmd>wincmd j<CR>")
nnoremap("<leader>k", "<cmd>wincmd k<CR>")
nnoremap("<leader>l", "<cmd>wincmd l<CR>")

-- resizing
nnoremap("<C-H><S-H>", "<cmd>vertical resize -4<CR>")
nnoremap("<C-L><S-L>", "<cmd>vertical resize +4<CR>")
nnoremap("<C-K><S-K>", "<cmd>resize +4<CR>")
nnoremap("<C-J><S-J>", "<cmd>resize -4<CR>")

-- telescope
nnoremap("<C-f>", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>ffh", "<cmd>Telescope find_files hidden=true<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")

-- todo-comments
nnoremap("<leader>ft", "<cmd>TodoTelescope<cr>")

nnoremap("<A>-a", "<C-a>")
nnoremap("<A>-x", "<C-x>")

