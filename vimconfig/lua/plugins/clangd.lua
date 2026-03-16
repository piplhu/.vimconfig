return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          -- 这里覆盖默认的启动命令和参数
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",

            -- =========================================
            -- 核心内存优化参数
            -- =========================================

            -- 1. 将预编译头存入硬盘（最重要！）
            "--pch-storage=disk",

            -- 2. 限制后台索引并发线程为 2
            "-j=2",

            -- 3. (Linux专用) 定期释放未使用的内存
            -- 如果你是 macOS，建议把这一行删掉，虽然加了通常也没事（会被忽略）
            "--malloc-trim",
          },
          -- 如果你需要自定义初始化的 options，可以在这里加
          -- init_options = { ... },
        },
      },
    },
  },
}
