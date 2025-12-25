-- lua/config/options.lua
local opt = vim.opt

-- 路径与备份 (Windows 兼容)
local data_dir = vim.fn.stdpath("data")
local backup_dir = data_dir .. "/backup"
local undo_dir = data_dir .. "/undo"

if vim.fn.isdirectory(backup_dir) == 0 then vim.fn.mkdir(backup_dir, "p") end
if vim.fn.isdirectory(undo_dir) == 0 then vim.fn.mkdir(undo_dir, "p") end

opt.backupdir = backup_dir
opt.directory = backup_dir
opt.undofile = true
opt.undodir = undo_dir

-- 界面与显示
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.hidden = true
-- 字体建议安装 JetBrainsMono Nerd Font 或 Source Code Pro Nerd Font
opt.guifont = "Source_Code_Pro_For_Powerline:h10" 
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.wildmenu = true
opt.updatetime = 100

-- 缩进
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.backspace = "indent,eol,start"

-- 编码
opt.fileencodings = "utf-8,chinese,gbk,gb18030,gk2312,latin-1"
opt.encoding = "utf-8"

-- 去除 GUI 元素
opt.guioptions:remove({"l", "L", "r", "R", "m", "T"})
