return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} }, -- used for lua and neovim docs and completion, TODO: neodev is now EOL, replace with lazydev.nvim
      "j-hui/fidget.nvim", 
  },
    config = function()
      local shared = require("common.shared")
      -- import lspconfig plugin
      local lspconfig = require("lspconfig")
  
      -- import mason_lspconfig plugin
      local mason_lspconfig = require("mason-lspconfig")
  
      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
  
      local keymap = vim.keymap -- for conciseness
  
      -- used to enable autocompletion (assign to every lsp server config)
      -- local capabilities = cmp_nvim_lsp.default_capabilities()
      local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities())

      -- for messages that come on the bottom right 
      require("fidget").setup({})
  
      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
  
      mason_lspconfig.setup_handlers({
        -- default handler for installed servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        -- ["svelte"] = function()
        --   -- configure svelte server
        --   lspconfig["svelte"].setup({
        --     capabilities = capabilities,
        --     on_attach = function(client, bufnr)
        --       vim.api.nvim_create_autocmd("BufWritePost", {
        --         pattern = { "*.js", "*.ts" },
        --         callback = function(ctx)
        --           -- Here use ctx.match instead of ctx.file
        --           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
        --         end,
        --       })
        --     end,
        --   })
        -- end,
        -- ["graphql"] = function()
        --   -- configure graphql language server
        --   lspconfig["graphql"].setup({
        --     capabilities = capabilities,
        --     filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        --   })
        -- end,
        ["emmet_ls"] = function()
          -- configure emmet language server
          lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          })
        end,
        ["lua_ls"] = function()
          -- configure lua server (with special settings)
          lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                -- make the language server recognize "vim" global
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
      })
    

      vim.diagnostic.config({
        -- update_in_insert = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = ""
        }
      })
    end,
  }
  