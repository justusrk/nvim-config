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
        end
        local function delete_character_to_right_of_cursor(prompt_bufnr)
            local current_line = vim.api.nvim_get_current_line()
            local cursor_pos = vim.api.nvim_win_get_cursor(0) -- cursor_pos = (row, col)
            if cursor_pos[2] < #current_line then -- if col < length of current_line
                local new_line = current_line:sub(1, cursor_pos[2]) .. current_line:sub(cursor_pos[2] + 2)
                vim.api.nvim_set_current_line(new_line)
            end
        end
        local function move_cursor_x(prompt_bufnr, dx)
            local current_line = vim.api.nvim_get_current_line()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            local to_cursor_x = cursor_pos[2] + dx
            if to_cursor_x > 0 and to_cursor_x <= #current_line then
                cursor_pos[2] = to_cursor_x
                vim.api.nvim_win_set_cursor(0, cursor_pos)
            end
            
        end
        local function move_cursor_to_right(prompt_bufnr)
            move_cursor_x(prompt_bufnr, 1)
        end
        local function move_cursor_to_left(prompt_bufnr) 
            move_cursor_x(prompt_bufnr, -1)
        end
        local function move_cursor_to_beginning(prompt_bufnr) 
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            vim.api.nvim_win_set_cursor(0, {cursor_pos[1], 2})
        end
        local function move_cursor_to_end(prompt_bufnr) 
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            local current_line = vim.api.nvim_get_current_line()
            vim.api.nvim_win_set_cursor(0, {cursor_pos[1], #current_line})
        end
        local telescope = require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<CR>"] = actions.select_default + actions.center,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,

                        ["<C-l>"] = delete_character_to_right_of_cursor,
                        -- some terminal like mappings
                        ["<C-f>"] = move_cursor_to_right,
                        ["<C-b>"] = move_cursor_to_left, 
                        ["<C-a>"] = move_cursor_to_beginning,
                        ["<C-e>"] = move_cursor_to_end, 

                        -- Beware the following keybindings require terminal to understand C-, C-. keypress
                        -- Works in iTerm2
                        ["<C-,>"] = actions.cycle_history_prev,
                        ["<C-.>"] = actions.cycle_history_next,
                    },
                    n = {
                        ["<CR>"] = actions.select_default + actions.center,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
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

