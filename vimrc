filetype off

call pathogen#infect()
call pathogen#helptags()

" Vundle related things
set runtimepath+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'marijnh/tern_for_vim'
Plugin 'klen/python-mode'
Plugin 'scrooloose/nerdtree'
Plugin 'Shougo/neosnippet'
Plugin 'tpope/vim-surround'
Plugin 'gmarik/Vundle.vim'
call vundle#end()            " required

filetype plugin indent on
syntax on

let g:SuperTabMappingForward = '<c-space>'
let g:SuperTabMappingBackward= '<s-c-space>'
let mapleader=","
inoremap <Leader>t <Tab>
" The mapping of tab to sec costs me jump navigation of <C-i>, reclaim it
nnoremap <c-u> <c-i>

" Fast saving
nmap <leader>w :w!<cr>
" Fast quitting
nmap <leader>q :q!<cr>

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Visual mode pressing * or # searches for the current selection Super useful!
" From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>v :call VisualSelection('gq')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" Code folding made easy
nnoremap <space> za
vnoremap <space> zc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! Get_visual_selection()
  " Why is this not a built-in Vim script function?!
  " Sid: Got it to work for me
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'gq'
        call CmdLine("%s" . '/'. Get_visual_selection() . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction


noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Spell check for the git commit file
autocmd FileType gitcommit setlocal spell
autocmd BufWritePre * :%s/\s\+$//e

" This will open a new split after you navigate from a 'tag' or
" it will goto the existing buffer for the tag, if one exists.
" TODO(Sid): Still need to complete this.
set switchbuf=useopen,usetab,split
function! AutoImportAutoImport()
    echom 'Fill me in some how...'
endfunction
" inoremap <expr> <space>  pumvisible() ? AutoImportAutoImport() : '\<space>'

let g:vimwiki_list=[{'path': '~/Dropbox/vimwiki/'}, {'path_html': '~/Dropbox/vimwiki_html/'}]

" Some Fugitive bindings.

"This helps you move up and down the tree.
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
" Dont select the first completion utesm insert the lingest common test of all
" matches and the menu will comeup even if there's only one match.
set completeopt=longest,menuone

" Neo cache compl with jedi/rope
let g:neocomplcache_enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
imap neosnippet#expandable() ? "(neosnippet_expand_or_jump)" : pumvisible() ? "" : ""
smap neosnippet#expandable() ? "(neosnippet_expand_or_jump)" :
let g:neocomplcache_force_overwrite_completefunc = 1
if !exists('g:neocomplcache_omni_functions')
  let g:neocomplcache_omni_functions = {}
endif
if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns['python'] = '[^. t].w*'
set ofu=syntaxcomplete#Complete
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python let b:did_ftplugin = 1

" So am going to replace my new neocomplcache snippets with

let g:neosnippet#snippets_directory="~/.vim/bundle/vim-snippets"
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"


" A long time coming... I think I should just get used to this more
" and let the tab key alone
onoremap jk <Esc>
inoremap jk <Esc>`^
inoremap <Esc> <nop>

" Lint python on the fly using pymode.
" When you bogie out of insert mode it does this for you.
let g:pymode_lint_on_fly = 1

" For SQLFormatting
let g:sqlutil_keyword_case = '\U'
let g:sqlutil_align_comma=1

" For vim powerline.
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
" Since we are using spaces every where we should make this happen
set expandtab

" Mouse for quick select!
set mouse=a
" Art Cat! Welcome
echo ">^.^< says welcome!"

