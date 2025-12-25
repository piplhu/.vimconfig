-- lua/plugins/editor.lua
return {
  -- 模糊搜索: Telescope (替换 LeaderF)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<Leader>sp", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<Leader>;", "<cmd>Telescope oldfiles<cr>", desc = "History" },
      { "<Leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    },
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules", ".git", "dist" },
      },
    },
  },

  -- 自动括号
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
