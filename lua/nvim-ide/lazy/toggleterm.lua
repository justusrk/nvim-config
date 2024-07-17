return {
    {
        'akinsho/toggleterm.nvim', 
        version = "*", 
        opts = {
            size = 20,
            open_mapping = [[<D-t>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = -30,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = 'horizontal',
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = 'single',
                winblend = 3,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                }
            }        
        }
    }

}