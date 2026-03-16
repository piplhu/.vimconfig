-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 放在 ~/.config/nvim/lua/config/autocmds.lua 里（没有就新建）

-- 示例1：所有 lua 文件不自动 format
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- 示例2：某个项目文件夹全部关闭
--vim.api.nvim_create_autocmd("BufEnter", {
--  pattern = vim.fn.expand("~") .. "/projects/legacy-code/*",
--  callback = function()
--    vim.b.autoformat = false
--  end,
--})
