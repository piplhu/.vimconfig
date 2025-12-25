-- ~/AppData/Local/nvim/init.lua

-- 设置 Leader 键 (必须在加载 lazy 之前设置)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 加载基础配置
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- 自动安装 Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 加载插件
require("lazy").setup("plugins", {
  ui = {
    border = "rounded",
  },
  change_detection = {
    notify = false,
  },
})
