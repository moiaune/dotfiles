scriptencoding utf-8

" Plugin specific settings
source $HOME/.config/nvim/plugins.vim

" Key mappings
source $HOME/.config/nvim/mappings.vim

" General settings
source $HOME/.config/nvim/config.vim

" COC spesific
source $HOME/.config/nvim/coc.vim

" TODO: split out into commands.vim
augroup dotpwsh
    autocmd!
    autocmd Filetype css setlocal tabstop=2
    autocmd Filetype css setlocal softtabstop=2
    autocmd Filetype css setlocal shiftwidth=2
    autocmd Filetype html setlocal tabstop=2
    autocmd Filetype html setlocal softtabstop=2
    autocmd Filetype html setlocal shiftwidth=2
    autocmd Filetype javascript setlocal tabstop=2
    autocmd Filetype javascript setlocal softtabstop=2
    autocmd Filetype javascript setlocal shiftwidth=2
augroup END

