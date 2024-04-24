return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-smart-history.nvim"
    },

    config = function()
        local telescope = require('telescope').setup({})

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
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        -- ToDo maybe use fzf native algo - https://github.com/nvim-telescope/telescope-fzf-native.nvim
        require('telescope').load_extension('smart_history')
    end
}

