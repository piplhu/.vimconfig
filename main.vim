if !isdirectory(expand("$HOME/.vimconfig/plugged"))
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set number
let mapleader="\<space>"
set relativenumber
set cursorline
set hidden
set guifont=Source_Code_Pro_For_Powerline:h11:b:cMAC:qDRAFT
set hlsearch
set updatetime=100

if !isdirectory(expand("$HOME/.vimconfig/tmp/backup"))
call mkdir($HOME . "/.vimconfig/tmp/backup", 'p')
endif
if !isdirectory(expand("$HOME/.vimconfig/tmp/undo"))
call mkdir($HOME . "/.vimconfig/tmp/undo", 'p')
endif
set backupdir=~/.vimconfig/tmp/backup
set directory=~/.vimconfig/tmp/backup
if has('persistent_undo')
    set undofile
    set undodir=~/.config/nvim/tmp/undo
endif

" 开启文件类型侦测
filetype on
" >>
" 文件类型侦测

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" <<
" >>
" vim 自身（非插件）快捷键

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至vim
nmap <Leader>p "+p

" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>

" 设置快捷键遍历子窗口
" 依次遍历
nnoremap nw <C-W><C-W>
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j

" <<

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" >>
" 其他

" 开启实时搜索功能
set incsearch

" 搜索时大小写不敏感
set ignorecase

" 关闭兼容模式
set nocompatible

" 启用退格键删除字符
set backspace=indent,eol,start

" vim 自身命令行模式智能补全
set wildmenu


" 禁止光标闪烁
set gcr=a:block-blinkon0

" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" 打开term
noremap <LEADER>/ :term<cr>
let g:neoterm_autoscroll = 1
" 退回到普通模式
tnoremap <Esc> <C-\><C-N>

" 解决中文乱码
set fileencodings=utf-8,chinese,gbk,gb18030,gk2312,latin-1
set encoding=utf-8

" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4

call plug#begin('~/.vimconfig/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'liuchengxu/vista.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'piplhu/vim-snippets'

if !executable('fzf')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
endif
Plug 'junegunn/fzf.vim'

if has('nvim')
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
Plug 'Shougo/defx.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()


colorscheme dracula

" coc.nvim
let g:coc_global_extensions = [
	\ 'coc-vimlsp',
	\ 'coc-clangd',
	\ 'coc-gitignore',
    \ 'coc-snippets']

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
"nnoremap <LEADER>fl :CocCommand explorer<CR> 
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

" coc_snippets
" ====
" 标签跳转
let g:coc_snippets_next = '<c-j>'
let g:coc_snippets_prev = 'c-k'

" ===
" === Leaderf
" ===
noremap <c-p> :Leaderf file<CR>
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
"set rtp+=/usr/local/opt/fzf
"set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
"set rtp+=/home/david/.linuxbrew/opt/fzf
"noremap <silent> <C-f> :Rg<CR>
"noremap <silent> <C-h> :History<CR>
"noremap <silent> <C-l> :Lines<CR>
"noremap <silent> <C-w> :Buffers<CR>
"noremap <leader>; :History:<CR>

let g:fzf_preview_window = 'down:30%:hidden'
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

" 选择删除buffer
command! BufferDelete call fzf#run(fzf#wrap({
 \ 'source': s:list_buffers(),
 \ 'sink*': { lines -> s:delete_buffers(lines) },
 \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept',
 \   'down': '40%'
 \}))
 
nnoremap <LEADER>sp :Rg!<Space>
noremap <c-d> :BufferDelete<CR>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
let g:fzf_layout = {'down': '40%' }
" ===
" === defx
" ===
nnoremap <F3> :Defx -toggle -auto-cd -split=vertical -winwidth=30 -direction=botright<CR> 
function! s:defx_my_settings() abort
	  " Define mappings
	  nnoremap <silent><buffer><expr> <CR>
	  \ defx#do_action('drop')
	  nnoremap <silent><buffer><expr> <right>
	  \ defx#do_action('drop')
	  nnoremap <silent><buffer><expr> c
	  \ defx#do_action('copy')
	  nnoremap <silent><buffer><expr> m
	  \ defx#do_action('move')
	  nnoremap <silent><buffer><expr> p
	  \ defx#do_action('paste')
	  nnoremap <silent><buffer><expr> l
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> E
	  \ defx#do_action('open', 'vsplit')
	  nnoremap <silent><buffer><expr> P
	  \ defx#do_action('preview')
	  nnoremap <silent><buffer><expr> o
	  \ defx#do_action('open_tree', 'toggle')
	  nnoremap <silent><buffer><expr> K
	  \ defx#do_action('new_directory')
	  nnoremap <silent><buffer><expr> N
	  \ defx#do_action('new_file')
	  nnoremap <silent><buffer><expr> M
	  \ defx#do_action('new_multiple_files')
	  nnoremap <silent><buffer><expr> C
	  \ defx#do_action('toggle_columns',
	  \                'mark:indent:icon:filename:type:size:time')
	  nnoremap <silent><buffer><expr> S
	  \ defx#do_action('toggle_sort', 'time')
	  nnoremap <silent><buffer><expr> d
	  \ defx#do_action('remove')
	  nnoremap <silent><buffer><expr> r
	  \ defx#do_action('rename')
	  nnoremap <silent><buffer><expr> !
	  \ defx#do_action('execute_command')
	  nnoremap <silent><buffer><expr> x
	  \ defx#do_action('execute_system')
	  nnoremap <silent><buffer><expr> yy
	  \ defx#do_action('yank_path')
	  nnoremap <silent><buffer><expr> .
	  \ defx#do_action('toggle_ignored_files')
	  nnoremap <silent><buffer><expr> ;
	  \ defx#do_action('repeat')
	  nnoremap <silent><buffer><expr> h
	  \ defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> <left>
	  \ defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> ~
	  \ defx#do_action('cd')
	  nnoremap <silent><buffer><expr> q
	  \ defx#do_action('quit')
	  nnoremap <silent><buffer><expr> <Space>
	  \ defx#do_action('toggle_select') . 'j'
	  nnoremap <silent><buffer><expr> *
	  \ defx#do_action('toggle_select_all')
	  nnoremap <silent><buffer><expr> j
	  \ line('.') == line('$') ? 'gg' : 'j'
	  nnoremap <silent><buffer><expr> k
	  \ line('.') == 1 ? 'G' : 'k'
	  nnoremap <silent><buffer><expr> <C-l>
	  \ defx#do_action('redraw')
	  nnoremap <silent><buffer><expr> <C-g>
	  \ defx#do_action('print')
	  nnoremap <silent><buffer><expr> cd
	  \ defx#do_action('change_vim_cwd')
endfunction
autocmd BufWritePost * call defx#redraw()


function! s:open_defx_if_directory()
	try
		let l:full_path = expand(expand('%:p'))
	catch
		return
	endtry
	if isdirectory(l:full_path)
		execute "Defx `expand('%:p')` | bd " . expand('%:r')
	endif
endfunction

augroup defx_config
	autocmd!
	autocmd FileType defx call s:defx_my_settings()
	autocmd BufEnter * call s:open_defx_if_directory()
augroup END

" ===
" " === Vista.vim
" " ===
 nnoremap  <F2>  :Vista!!<CR>
 noremap <c-t> :silent! Vista finder coc<CR>
 let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
 let g:vista_default_executive = 'coc'
 let g:vista_fzf_preview = ['right:50%']
 let g:vista#renderer#enable_icon = 1
 let g:vista#renderer#icons = {
 \   "function": "\uf794",
 \   "variable": "\uf71b",
 \  }

let g:vista_close_on_jump = 1
let g:vista_sidebar_position = "vertical topleft"
let g:scrollstatus_size = 15



" ===
" === vim-airline
" ===
" 关闭当前buffer
nnoremap <LEADER>bq :bd<CR>
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:Powerline_sybols = 'unicode'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {}
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnametruncate = 0 
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
if get(g:, 'airline_powerline_fonts', 0)
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
  let g:airline_symbols.maxlinenr= ''
endif
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type= 2
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffers_label = 'BUFFERS'
let g:airline#extensions#tabline#tabs_label = 'TABS'
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab

