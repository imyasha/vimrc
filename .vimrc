set term=screen-256color
set nu
syntax on
"colorscheme desert
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set smartindent
set autoindent
set hlsearch
"set autoread
set encoding=utf-8

let mapleader = ","

nnoremap <leader>t :tabnew<CR> 
nnoremap <leader>mn :set mouse=<CR> 
nnoremap <leader>ma :set mouse=a<CR> 

"nnoremap <leader>TG :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .

execute pathogen#infect()
filetype plugin indent on

"airline{
set t_Co=256
set nocompatible
set laststatus=2
let g:airline_theme='dark'
"}

"color{
let g:solarized_termcolors=256
"colorscheme solarized
set background=dark
colorscheme mytomorrow
"}

"NERDTree{
nnoremap <leader>f : NERDTreeToggle<CR>
let NERDTreeWinSize = 50
"}

"taglist{
let Tlist_Inc_Winwidth = 1
let Tlist_WinWidth = 60
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
"let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_Ctags_Cmd='/opt/local/bin/ctags'
nnoremap <leader>l : Tlist<CR>
"}

"OmniCppComplete{
set completeopt=longest,menu
"}

"auto update ctags{
"./TAGS is for adding files
"./tags is for all
function UPDATE_TAGS()
    if filereadable("./TAGS")
        let _f_ = expand("%:p")
        let _cmd_ = "ctags -f ./TAGS -a --c++-kinds=+p --fields=+iaS --extra=+q " . '"' . _f_ . '"'
        "echo _cmd_
        let _resp = system(_cmd_)
        unlet _cmd_
        unlet _f_
        unlet _resp
    endif
endfunction

"./CSCOPE.out is for adding files
"./cscope.out is for all
function UPDATE_CSCOPE()
    if filereadable("./need_CSCOPE")
        silent! execute "cs kill ./CSCOPE.out"
        let _f_ = expand("%:p")
        let _cmd_ = "echo " . '"' . _f_ . '"' . "> ./cscope_add_file"
        let _resp = system(_cmd_)
        let _cmd_ = "cscope -bkq -f ./CSCOPE.out -i " . "./cscope_add_file"
        let _resp = system(_cmd_)
        silent! execute "cs add ./CSCOPE.out"
        silent! execute "cs reset"
        unlet _cmd_
        unlet _f_
        unlet _resp
    endif
endfunction
autocmd BufWrite *.cc,*.cpp,*.h,*.c,*.go call UPDATE_TAGS()
autocmd BufWrite *.cc,*.cpp,*.h,*.c,*.go call UPDATE_CSCOPE()
"double confirm
autocmd BufWritePost *.cc,*.cpp,*.h,*.c,*.go call UPDATE_TAGS()
autocmd BufWritePost *.cc,*.cpp,*.h,*.c,*.go call UPDATE_CSCOPE()
"}

"hotkey for cscope{
if filereadable("./cscope.out")
    silent! execute "cs add ./cscope.out"
endif
if filereadable("./CSCOPE.out")
    silent! execute "cs add ./CSCOPE.out"
endif
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<cr><cr>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<cr><cr>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<cr><cr>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<cr><cr>
"}

"configure for YCM{
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_show_diagnostics_ui=0
""}
