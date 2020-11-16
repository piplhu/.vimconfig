
" 如果没有vim-plug自动安装
if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                   \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===
" === Editor behavior
" ===
set number
set relativenumber
set cursorline
set hidden
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu
set ignorecase
set smartcase
set shortmess+=c
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
   set undofile
   set undodir=~/.config/nvim/tmp/undo,.
endif
set colorcolumn=100
set updatetime=100
set virtualedit=block

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" 让配置变更立即生效
"autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 设置<LEADER> 为 <SPACE>
let mapleader="\<space>"

" 打开term
noremap <LEADER>/ :set splitbelow<cr>:split<cr>:res -10<cr>:term<cr>
let g:neoterm_autoscroll = 1
" 打开自动进入输入模式
autocmd TermOpen term://* startinsert
" 退回到普通模式
tnoremap <Esc> <C-\><C-N>


" 打开配置文件
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>


" Y复制到行尾
noremap Y y$

" 复制到系统剪切板
vnoremap <LEADER>y "+y

" 关闭搜索高亮
noremap <LEADER><CR> :nohlsearch<CR>

" 快速移动词
noremap W 5w
noremap B 5b

inoremap <C-a> <ESC>A


" 窗口移动
noremap <LEADER>w <C-w>w
noremap <LEADER>kk <C-w>k
noremap <LEADER>jj <C-w>j
noremap <LEADER>hh <C-w>h
noremap <LEADER>ll <C-w>l

" 窗口分割
noremap <LEADER>js :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap <LEADER>ks :set splitbelow<CR>:split<CR>
noremap <LEADER>hs :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap <LEADER>ls :set splitright<CR>:vsplit<CR>

" 关闭当前窗口的下一个窗口
noremap <LEADER>q <C-w>j:q<CR>


" 创建新的tab
noremap tu :tabe<CR>
" 切换tab页
noremap tk :-tabnext<CR>
noremap tj :+tabnext<CR>
" 移动tab页
noremap tmk :-tabmove<CR>
noremap tmj :+tabmove<CR>

" Spelling Check with <space>sc
noremap <LEADER>sc :set spell!<CR>

" 恢复自动折行
noremap <LEADER>sw :set wrap<CR>

" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
call plug#end()

" coc.nvim
let g:coc_global_extensions = [
	\ 'coc-vimlsp',
	\ 'coc-clangd',
	\ 'coc-json',
	\ 'coc-gitignore',
	\ 'coc-explorer']

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

noremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <LEADER>fl :CocCommand explorer<CR> 
nmap <leader>rn <Plug>(coc-rename)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)

function! s:cocActionsOpenFromSelected(type) abort
	execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@



" ===
" === Leaderf
" ===
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewCode = 1
let g:Lf_ShowHidden = 1
let g:Lf_ShowDevIcons = 1
"et g:Lf_CogandMap = {
"   '<C-k>': ['<C-u>'],
"   '<C-j>': ['<C-e>'],
"   '<C-]>': ['<C-v>'],
"   '<C-p>': ['<C-n>'],
"}
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WildIgnore = {
       \ 'dir': ['.git', 'vendor', 'node_modules'],
       \ 'file': ['__vim_project_root']
       \}
let g:Lf_UseMemoryCache = 0
let g:Lf_UseCache = 0


" ===
" === FZF
" ===
set rtp+=/usr/local/opt/fzf
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
set rtp+=/home/david/.linuxbrew/opt/fzf
noremap <c-p> :Leaderf file<CR>
noremap <silent> <C-f> :Rg<CR>
noremap <silent> <C-h> :History<CR>
noremap <silent> <C-l> :Lines<CR>
noremap <silent> <C-w> :Buffers<CR>
noremap <leader>; :History:<CR>

let g:fzf_preview_window = 'right:60%'
let g:fzf_cogits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
 redir => list
 silent ls
 redir END
 return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
 execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
 \ 'source': s:list_buffers(),
 \ 'sink*': { lines -> s:delete_buffers(lines) },
 \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
 \}))

noremap <c-d> :BD<CR>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }



