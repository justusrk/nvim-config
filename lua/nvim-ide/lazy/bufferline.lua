return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'famiu/bufdelete.nvim'
    },
    config = function ()
        require('bufferline').setup {
            options = {
                numbers = "ordinal",
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local s = " "
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and " "
                            or (e == "warning" and " " or " ")
                        s = s .. n .. sym
                    end
                    return s
                end,
                show_buffer_close_icons = true,
                show_close_icon = true,
                show_tab_indicators = true,
                separator_style = "thin",
                always_show_bufferline = false,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        
                    },
                    {
                        filetype = "undotree",
                        text = "Undo Tree",
                        text_align = "center",
                        
                    }
                },
                custom_filter = function(buf_number, buf_numbers)
                    -- filter out filetypes you don't want to see
                    -- print(vim.bo[buf_number].filetype)
                    if vim.bo[buf_number].filetype == "qf" then
                        return false
                    end
                    if vim.bo[buf_number].filetype == "NvimTree" then
                        return false
                    end
                    return true
                end,
                -- close_command = require('bufdelete').bufdelete, -- don't know if this works
            }
        }
        -- Beware the following keybindings require terminal to understand D-, D-. keypress
        -- Works in iTerm2 and Neovide
        vim.keymap.set("n", "<D-.>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true }) 
        vim.keymap.set("n", "<D-,>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
        -- We could also use C-] and C-[ but we don't want to override the default behavior
        -- default C-] (jump to definition for tags in vim) 
        -- default C-[ simulates the Esc character
    end
}
