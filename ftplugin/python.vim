setlocal nu
set hlsearch
autocmd BufRead,BufNewFile *.py setlocal spell
" Load rope plugin
let g:pymode_rope = 1

let g:pymode_virtualenv = 1

" Map keys for autocompletion let g:pymode_rope_completion=1
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
" Make sure certain lint messages are on.
let g:pymode_lint_on_fly = 1
let g:pymode_lint_on_write = 1
let g:pymode_lint_unmodified = 1
let g:pymode_lint_message = 1

" Enable the options for setting textwidth = 99
" and setting colormode to draw a red line down the 100 column mark
let g:pymode_options_max_line_length = 99
let g:pymode_options_colorcolumn = 1

" Options for jedi
let g:jedi#auto_initialization = 0
"There are also some VIM options (like completeopt and key defaults) which are automatically initialized, but you can change all of them:

let g:jedi#auto_vim_configuration = 0
"If you are a person who likes to use VIM-buffers not tabs, you might want to put that in your .vimrc:

let g:jedi#use_tabs_not_buffers = 0
"If you are a person who likes to use VIM-splits, you might want to put this in your .vimrc:

let g:jedi#use_splits_not_buffers = "left"
"This options could be "left", "right", "top" or "bottom". It will decide the direction where the split open.

"Jedi automatically starts the completion, if you type a dot, e.g. str., if you don't want this:

let g:jedi#popup_on_dot = 0
"Jedi selects the first line of the completion menu: for a better typing-flow and usually saves one keypress.

let g:jedi#popup_select_first = 0

set expandtab

" Also add in indent folding for the win
set foldmethod=indent

let g:pymode_rope_regenerate_on_write = 0

" Allow for better doc strings
let g:ultisnips_python_style="sphinx"

"
if g:pymode_rope
    au BufWriteCmd *.py write || :PymodeLint
endif
