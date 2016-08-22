augroup filetypedetect
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
augroup END
set ts=4
set expandtab
set tabstop=4
set shiftwidth=4
map <F2> :retab <CR>
map <F3> :retab <CR> :wq! <CR>
