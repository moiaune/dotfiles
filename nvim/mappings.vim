let mapleader=" "

nnoremap <C-f> :GFiles<CR>

nmap <leader>cr <Plug>(coc-references)

" Remap GoBack to C-a
nmap <C-a> <C-o>

map <C-p> :NERDTreeToggle<CR>

" --- TABS ---
autocmd TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <C-l> :exe "tabn ".g:lasttab<CR>
vnoremap <silent> <C-l> :exe "tabn ".g:lasttab<CR>

nnoremap <C-Right> :tabn<CR>
nnoremap <C-Left> :tabp<CR>

nnoremap <CR> :nohlsearch<CR><CR>
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+1<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+1<CR>
vnoremap <S-Up> :m '<-2<CR>gv=gv
vnoremap <S-Down> :m '>+1<CR>gv=gv

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

nmap <C-h> :vertical resize -4<CR>
nmap <C-l> :vertical resize +4<CR>
nmap <C-k> :resize +4<CR>
nmap <C-j> :resize -4<CR>

nmap <leader>" ysiw"
nmap <leader>] ysiw]
nmap <leader>} ysiw}

nmap <leader>gs :tabe<CR>:Gstatus<CR>
nmap <leader>gc :Gcommit<CR>

" Tabbing in visual mode
vmap <Tab> >gv

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Show warnings
nnoremap <leader>d :CocDiagnostics<CR>

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
