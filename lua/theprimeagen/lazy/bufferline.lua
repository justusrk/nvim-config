return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
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
                        
                    }
                },
                ignore_filetype = {
                    "NvimTree",
                    "help"
                },
            }
        }
    end
}
