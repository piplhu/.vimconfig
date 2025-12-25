-- lua/config/keymaps.lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 窗口操作
map("n", "<Leader>q", ":q<CR>", opts)
map("n", "<Leader>w", ":w<CR>", opts)
map("n", "<Leader>lw", "<C-W>l", opts)
map("n", "<Leader>hw", "<C-W>h", opts)
map("n", "<Leader>kw", "<C-W>k", opts)
map("n", "<Leader>jw", "<C-W>j", opts)
map("n", "nw", "<C-W><C-W>", opts)

-- 剪贴板
map("v", "<Leader>y", '"+y', opts)
map("n", "<Leader>p", '"+p', opts)

-- 其他
map("n", "<LEADER><CR>", ":nohlsearch<CR>", opts)
map("n", "<LEADER>/", ":term<cr>", opts)
map("t", "<Esc>", [[<C-\><C-N>]], opts)

-- === 保留你的 Replace 函数 ===
-- 因为这个逻辑包含正则和 input，用 vim.cmd 封装最稳妥
vim.cmd([[
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm | let flag .= 'gec' | else | let flag .= 'ge' | endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute '%s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
]])

map("n", "<Leader>R", ":call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>", opts)
map("n", "<Leader>rw", ":call Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>", opts)
map("n", "<Leader>rc", ":call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>", opts)
map("n", "<Leader>rcw", ":call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>", opts)
