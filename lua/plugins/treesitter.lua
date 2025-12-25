return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",                  -- 每次插件更新后自动运行 TSUpdate
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- 可选，但常用
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- 自动安装以下语言的 parser（推荐至少包含这些核心语言）
      ensure_installed = {
        "lua", "vim", "vimdoc", "query",    -- Neovim 自身必需
        "c", "cpp", "python", "javascript", "typescript",
        "html", "css", "json", "bash", "markdown",
        -- 根据你的需求继续添加，例如：go, rust, java 等
      },

      -- 自动安装缺少的 parser（当打开新文件类型时）
      auto_install = true,

      -- 高亮、缩进、折叠 等功能
      highlight = {
        enable = true,
        -- 有些语言（如 latex）可能高亮冲突，可禁用
        -- disable = { "latex" },
      },
      indent = {
        enable = true,
        -- 注意：某些语言 indent 效果不好，可单独禁用
        -- disable = { "python" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },

      -- 可选：增强文本对象（如函数、类选择）
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    })

    -- 可选：设置折叠使用 treesitter
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false  -- 默认不折叠，zo/zc 手动控制
  end,
}
