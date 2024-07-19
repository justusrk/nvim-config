-- Trouble is for listing errors and warnings something like quickfix but with more features
return {{
    "folke/trouble.nvim",
    opts = {
        -- modes: {
        --     symbols: {
        --         mode = 'symbols',
        --         win = {
        --             size: {
        --                 width: 50  -- 50% of screen width, but at least 50 columns
        --             }
        --             height: 1.0

        --         }
        --     }
        -- }
    },
    cmd = "Trouble",
    dependencies = {"nvim-tree/nvim-web-devicons"},

    keys = {
        -- {
        --   "<leader>tD",
        --   "<cmd>Trouble diagnostics toggle<cr>",
        --   desc = "Diagnostics (Trouble)",
        -- },
        -- {
        --   "<leader>td",
        --   "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        --   desc = "Buffer Diagnostics (Trouble)",
        -- },
        -- {
        --   "<leader>cs",
        --   "<cmd>Trouble symbols toggle focus=false<cr>",
        --   desc = "Symbols (Trouble)",
        -- },
        -- {
        --   "<leader>cl",
        --   "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        --   desc = "LSP Definitions / references / ... (Trouble)",
        -- },
        -- {
        --   "<leader>tl",
        --   "<cmd>Trouble loclist toggle<cr>",
        --   desc = "Location List (Trouble)",
        -- },
        -- {
        --   "<leader>tq",
        --   "<cmd>Trouble qflist toggle<cr>",
        --   desc = "Quickfix List (Trouble)",
        -- },
    },

    config = function()
        local trouble = require("trouble");
        -- bottom window trouble
        bottom_trouble_window_config = {
            win = {
                type = "split",
                relative = "win",
                position = "bottom",
                size = {
                    width = 1,
                    height = 0.4
                }
            },
            preview = {
                type = "split",
                relative = "win",
                position = "right",
                size = {
                    width = 0.5,
                    height = 1,
                }
            }
        }
        right_trouble_window_config = {
            win = {
                type = "split",
                relative = "win",
                position = "right",
                size = {
                    width = 0.45,
                    height = 1
                }
            },
            preview = {
                type = "split",
                relative = "win",
                position = "top",
                size = {
                    width = 1,
                    height = 0.5
                }
            }
        }
        trouble.setup({
            modes = {
                my_diagnostics_global = {
                    mode = "diagnostics", -- inherit from diagnostics mode
                    -- auto_preview = true,
                    -- follow = true,
                    win = bottom_trouble_window_config.win,
                    preview = bottom_trouble_window_config.preview
                },
                my_diagnostics_local = {
                    mode = "diagnostics", -- inherit from diagnostics mode
                    -- auto_preview = true,
                    -- follow = true,
                    filter = { buf = 0 },
                    win = bottom_trouble_window_config.win,
                    preview = bottom_trouble_window_config.preview
                },
                my_quickfix = {
                    mode = "quickfix",
                    win = bottom_trouble_window_config.win,
                    preview = bottom_trouble_window_config.preview
                },
                my_loclist = {
                    mode = "loclist",
                    win = bottom_trouble_window_config.win,
                    preview = bottom_trouble_window_config.preview
                },
                my_symbols = {
                    mode = "symbols", -- inherit from symbols mode
                    auto_preview = false,
                    win = right_trouble_window_config.win,
                    preview = right_trouble_window_config.preview
                },
                my_lsp = {
                    mode = "lsp",
                    auto_preview = true,
                    auto_refresh = true,
                    win = right_trouble_window_config.win,
                    preview = right_trouble_window_config.preview
                }
            }
        })

        -- local default_mode = "diagnostics"
        -- vim.g.justusrk_last_trouble_mode = default_mode;

        -- vim.keymap.set("n", "<leader>td", function() -- diag only current file
        --     local mode = "diagnostics"
        --     print('modeis' ..mode)
        --     vim.g.justusrk_last_trouble_mode = mode
        --     vim.cmd('Trouble ' .. mode .. ' toggle filter.buf=0')
        -- end)
        -- vim.keymap.set("n", "<leader>tD", function() -- diag all open files
        --     local mode = "diagnostics"
        --     vim.g.justusrk_last_trouble_mode = mode
        --     vim.cmd('Trouble ' .. mode .. ' toggle')
        --     trouble.toggle(mode);
        -- end)
        -- vim.keymap.set("n", "<leader>tq", function()
        --     local mode = "quickfix"
        --     vim.g.justusrk_last_trouble_mode = mode
        --     trouble.toggle(mode);
        -- end)
        -- vim.keymap.set("n", "<leader>tl", function()
        --     local mode = "loclist"
        --     vim.g.justusrk_last_trouble_mode = mode
        --     trouble.toggle(mode);
        -- end)

        -- vim.keymap.set("n", "<leader>tt", function()
        --     local mode = vim.g.justusrk_last_trouble_mode or default_mode
        --     trouble.toggle(mode);
        -- end)

        -- vim.keymap.set("n", "<D-j>", function()
        --     local mode = vim.g.justusrk_last_trouble_mode or default_mode
        --     trouble.next(mode);
        --     trouble.jump(mode);
        -- end)

        -- vim.keymap.set("n", "<D-k>", function()
        --     local mode = vim.g.justusrk_last_trouble_mode or default_mode
        --     trouble.prev(mode);
        --     trouble.jump(mode);

        -- end)

    end
}}
