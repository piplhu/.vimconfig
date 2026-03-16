-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ~/.config/nvim/lua/config/options.lua
-- Add any additional options here
vim.opt.expandtab = true -- 把 Tab 键转成空格（强烈推荐）
vim.opt.tabstop = 4 -- 一个 Tab 显示为 4 个空格宽度
vim.opt.softtabstop = 4 -- 按 Tab 时插入 4 个空格（编辑体验最佳）
vim.opt.shiftwidth = 4 -- >>、<<、自动缩进时使用 4 个空格

-- 可选：让退格键一次删掉一个缩进级别（很爽）
vim.opt.smarttab = true
