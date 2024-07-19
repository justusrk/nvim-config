-- completions


return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer", -- source for text in buffer
            "hrsh7th/cmp-path", -- source for file system paths
            {
            "L3MON4D3/LuaSnip", -- snippet engine in lua
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
            },
            "saadparwaiz1/cmp_luasnip", -- luasnip's completion source for nvim-cmp
            "rafamadriz/friendly-snippets", -- useful vscode like snippets
            "onsails/lspkind.nvim", -- vscode like pictograms
        },
        config = function()
            local cmp = require("cmp")

            local luasnip = require("luasnip")

            local lspkind = require("lspkind")

            local neogen = require('neogen')

            -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
            require("luasnip.loaders.from_vscode").lazy_load()
            
            local cmp_select_options = {
              behavior = cmp.SelectBehavior.Select -- don't preview the selected item in the buffer without this the selected option replaces the typed text
            }

            cmp.setup({
                completion = {
                  completeopt = "menu,menuone,preview,noselect",
                },
                snippet = { -- configure how nvim-cmp interacts with snippet engine
                  expand = function(args)
                    luasnip.lsp_expand(args.body)
                  end,
                },
                mapping = cmp.mapping.preset.insert({
                  ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                  ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select_options), -- previous suggestion
                  ["<C-n>"] = cmp.mapping.select_next_item(cmp_select_options), -- next suggestion
                  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                  ["<C-f>"] = cmp.mapping.scroll_docs(4),
                  ["<C-c>"] = cmp.mapping.abort(), -- close completion window
                  ["<CR>"] = cmp.mapping.confirm({ select = false }),
                  ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- will confirm the first one in list without needing to select it 
                  ["<C-.>"] = cmp.mapping(function(fallback)
                      if luasnip and luasnip.expand_or_jumpable() then
                          luasnip.expand_or_jump()
                      else
                          fallback()
                      end
                  end, {"i", "s"}),
                  ["<C-,>"] = cmp.mapping(function(fallback)
                      if luasnip and luasnip.jumpable(-1) then
                          luasnip.jump(-1)
                      else
                          fallback()
                      end
                  end, {"i", "s"})

                }),
                -- sources for autocompletion
                sources = cmp.config.sources({
                  { name = "nvim_lsp"}, -- lsp completions provides snippers, keywords, variables, etc..
                  { name = "luasnip" }, -- lua snippets completion
                  { name = "buffer" }, -- text within current buffer
                  { name = "path" }, -- file system paths
                }),
          
                -- configure lspkind for vs-code like pictograms in completion menu
                formatting = {
                  format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                  }),
                },
            })
        end
    }
}