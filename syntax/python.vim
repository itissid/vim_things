setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal smartindent
setlocal formatoptions=croql
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py :%s/\s\+$//e
let g:syntastic_python_checkers=['pylint']
