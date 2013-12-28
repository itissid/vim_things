setlocal formatoptions=croql
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py :%s/\s\+$//e
