setlocal nu
set hlsearch
autocmd BufRead,BufNewFile *.py setlocal spell
" Load rope plugin
let g:pymode_rope = 1

let g:pymode_virtualenv = 1

" Map keys for autocompletion
let g:pymode_rope_autocomplete_map = '<C-Space>'

let g:pymode_rope_extended_complete=1

" Auto create and open ropeproject
let g:pymode_rope_auto_project = 1

" Enable autoimport
let g:pymode_rope_enable_autoimport = 1

" Auto generate global cache
let g:pymode_rope_autoimport_generate = 1

let g:pymode_rope_autoimport_underlineds = 0

let g:pymode_rope_codeassist_maxfixes = 10

let g:pymode_rope_sorted_completions = 1

let g:pymode_rope_extended_complete = 1

let g:pymode_rope_autoimport_modules = ["os","shutil","datetime"]

let g:pymode_rope_confirm_saving = 1

let g:pymode_rope_global_prefix = "<C-x>p"

let g:pymode_rope_local_prefix = "<C-c>r"

let g:pymode_rope_vim_completion = 1

let g:pymode_rope_guess_project = 1

let g:pymode_rope_goto_def_newwin = ""

let g:pymode_rope_always_show_complete_menu = 0

" Ignore specific warnings
let g:pymode_lint_ignore = "W191,E251,E128,E126,E127"

set noexpandtab
