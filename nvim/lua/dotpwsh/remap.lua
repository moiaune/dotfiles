local nmap = require('dotpwsh.keymap').nmap
local vmap = require('dotpwsh.keymap').vmap
local nnoremap = require('dotpwsh.keymap').nnoremap
local inoremap = require('dotpwsh.keymap').inoremap
local vnoremap = require('dotpwsh.keymap').vnoremap

-- open netwrt
nnoremap("<leader>pv", "<cmd>Ex<CR>")

nnoremap("<leader>b", "<cmd>Buffers<CR>")

nmap("<C-a>", "<C-o>")

-- move lines up/down
nnoremap("<S-Up>", "<cmd>m-2<CR>")
nnoremap("<S-Down>", "<cmd>m+1<CR>")
inoremap("<S-Up>", "<Esc><cmd>m-2<CR>")
inoremap("<S-Down>", "<Esc><cmd>m+1<CR>")
vnoremap("<S-Up>", ":m '<-2<CR>gv=gv")
vnoremap("<S-Down>", ":m '>+1<CR>gv=gv")

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

-- indenting
vmap("<Tab>", ">gv")
vmap("<S-Tab>", "<gv")

-- telescope
nnoremap("<C-f>", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>ffh", "<cmd>Telescope find_files hidden=true<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")

