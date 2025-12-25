-- lua/plugins/ui.lua
return {
  -- 主题: Dracula
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme dracula]])
    end,
  },

  -- 图标支持 (很多现代插件需要)
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- 状态栏: Lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "dracula" },
      })
    end,
  },

  -- 文件浏览器: Neo-tree (替换 Defx)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<F3>", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
    },
    opts = {
      window = { width = 30 },
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true, -- 自动检测文件变动
      },
    },
  },
}
