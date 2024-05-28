return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-smart-history.nvim"
    },

    config = function()
        local actions = require('telescope.actions')
        local action_state = require('telescope.actions.state')

        local function delete_from_start_to_cursor(prompt_bufnr)
            local current_line = action_state.get_current_line()
            local cursor_pos = vim.fn.getcurpos()[3] -- Use the logical column number
            local new_line = '> ' .. string.sub(current_line, cursor_pos)
            vim.api.nvim_buf_set_lines(prompt_bufnr, 2, -1, false, {new_line})
-- asd as asd asd f1 asd 
        end

        local telescope = require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = actions.select_default + actions.center,
                        ["<C-,>"] = actions.cycle_history_prev,
                        ["<C-.>"] = actions.cycle_history_next,
                        -- some terminal like mappings
                        ["<C-u>"] = delete_from_start_to_cursor,
                        ["<C-w>"] = function()
                            vim.cmd [[normal! cb]]
                        end,
                    },
                    n = {
                        ["<C-j>"] = actions.select_default + actions.center,
                        ["<C-,>"] = actions.cycle_history_prev,
                        ["<C-.>"] = actions.cycle_history_next
                        
                    }
                }
            }
        })
        

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>fo', builtin.resume, {}) -- find opened results
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- find files 
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {}) -- find open buffers 
        vim.keymap.set('n', '<leader>fgf', builtin.git_files, {}) -- find git files
        vim.keymap.set('n', '<leader>fws', function() -- find word under cursor
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word }) -- search for word under cursor
        end)
        vim.keymap.set('n', '<leader>fWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word }) -- search for WORD under cursor
        end)
        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") }) -- search for grep input
        end)
        vim.keymap.set('n', '<leader>fls', function()
            builtin.live_grep() -- live grep (might be less performant - does entire regex search on each term)
        end)
        vim.keymap.set('n', '<leader>hv', builtin.help_tags, {})
        -- ToDo maybe use fzf native algo - https://github.com/nvim-telescope/telescope-fzf-native.nvim
        require('telescope').load_extension('smart_history')
    end
}

