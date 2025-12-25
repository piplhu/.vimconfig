-- lua/plugins/lsp.lua
return {
  -- Mason: 管理 LSP 服务器
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  
  -- LSP 配置
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- 补全源
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 确保 mason 安装的工具能被 lspconfig 自动设置
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clangd" }, -- 自动安装这些
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,
        },
      })

      -- LSP 快捷键 (类似你原来的配置)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "Format", vim.lsp.buf.format, opts)
        end,
      })
    end,
  },

  -- 自动补全引擎: nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", -- 缓冲区内容
      "hrsh7th/cmp-path",   -- 路径
      "L3MON4D3/LuaSnip",   -- 代码片段引擎
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
             if cmp.visible() then cmp.select_next_item()
             elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
             else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
