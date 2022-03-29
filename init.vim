" 打开 24 位真彩色支持
set termguicolors
" 搜索的时候忽略大小字字母
set ignorecase
" 若搜索内容中有大写字母，则不再忽略大小写
set smartcase
" 高亮第80列
" set colorcolumn=80
" 高亮光标所在行
set cursorline


call plug#begin('~/.vim/plugged')
" 主题
Plug 'jacoborus/tender.vim'
" 目录树
Plug 'scrooloose/nerdtree'
" 状态栏美化
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" 开屏美化
Plug 'mhinz/vim-startify'
" Golang 相关
Plug 'fatih/vim-go'
" LSP client
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 错误处理
Plug 'dense-analysis/ale'
" 快速注释
Plug 'tpope/vim-commentary'
" 快速跳转
Plug 'easymotion/vim-easymotion'
" 匹配括号，自动缩进
Plug 'jiangmiao/auto-pairs'
" fzf 查找
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

" 上一次光标所在的位置
autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$")
      \ |   exe "normal! g`\""
      \ | endif

" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme tender
" 此处对 tender 主题略做调整，大家可以去掉对比一下效果
autocmd ColorScheme tender
\ | hi Normal guibg=#000000
\ | hi SignColumn guibg=#000000 "
\ | hi StatusLine guibg=#444444 guifg=#b3deef

" NerdTree
nnoremap <leader>v :NERDTreeFind<cr>
nnoremap <leader>g :NERDTreeToggle<cr>
let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeWinSize = 24

" \h关闭高亮
nnoremap <silent> <leader>h :noh<return><esc>

" vim-go
" 取消绑定K
let g:go_doc_keywordprg_enabled = 0

let g:go_fmt_command = 'goimports'
let g:go_autodetect_gopath = 1
" let g:go_bin_path = '$GOBIN'
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

augroup go
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END

" Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gm <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" ale-setting {{{
let g:ale_set_highlights = 1
let g:ale_set_quickfix = 1
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"打开文件时不进行检查
let g:ale_lint_on_enter = 1

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
" en Error Next 
" ep Error Previous
nmap ep <Plug>(ale_previous_wrap)
nmap en <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
" nmap <Leader>l :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
let g:ale_linters = {
    \ 'go': ['golint', 'go vet', 'go fmt'],
    \ }

" easymotion
nmap ss <Plug>(easymotion-s2)

" 更快速的移动光标
noremap J 10j
noremap K 10k

" fzf
nnoremap <silent> <C-f> :Files<CR>

" 标签页显示文件名
set guitablabel=%t

