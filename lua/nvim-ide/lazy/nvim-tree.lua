local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end
    
    -- Define the function to move to the rough previous window and open
    -- open in the nvim-tree window iteself if there is no other window
    -- open in the other window if only 2 windows (one is nvim-tree and other could be anything)
    -- open in the previous window if openable else first reverse cycled openable window if there are more than 2 window
    -- if there are no openable windows then it will open in the last unopenable window
    -- for what is openable window see the function below
    local function move_previous_and_harpoon()
        -- Get the current window number and layout
        local current_win = vim.api.nvim_get_current_win()
        local win_info = vim.fn.winlayout()
    
        local is_single_window = false
        -- check if only one window is open
        if win_info[1] == 'leaf' then
            is_single_window = true
        end
        

        local get_current_win_buftype = function()
            local bufnr = vim.api.nvim_win_get_buf(0)  -- Get the buffer number of the current window
            return vim.api.nvim_buf_get_option(bufnr, 'buftype')  -- Get the value of 'buftype' for the buffer
        end

        local get_current_win_filetype = function()
            local bufnr = vim.api.nvim_win_get_buf(0)  -- Get the buffer number of the current window
            return vim.api.nvim_buf_get_option(bufnr, 'filetype')  -- Get the value of 'filetype' for the buffer
        end

        local function is_openable_window() -- returns false for terminals and nvim-tree and quickfix
            local buftype = get_current_win_buftype()
            return not (buftype == 'terminal' or buftype == 'quickfix' or buftype == 'nofile')
        end
    
        -- Move to the previous valid window if there are multiple windows
        if not is_single_window then
            vim.cmd('wincmd p')
            local total_other_windows = vim.fn.winnr('$') - 1 -- subtract nvim-tree window
            local count = 1
            while count < total_other_windows and not is_openable_window() do
                vim.cmd('wincmd W') -- go cycle previous window if it is non openable window
                if get_current_win_filetype() == 'NvimTree' then -- check if it is nvim-tree window
                    vim.cmd('wincmd W') -- go cycle one more previous window 
                end
                count = count + 1
            end
        end

        local harpoon = require("harpoon");
        harpoon.ui:toggle_quick_menu(harpoon:list())
        vim.api.nvim_command('stopinsert') -- stop insert mode - useful when we have come from terminal window, the insert mode is still on
    end

    -- default mappings
    -- api.config.mappings.default_on_attach(bufnr)
    -- custom mappings

    vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
    -- vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place')) -- disable to use harpoon
    vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
    vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
    -- vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab')) -- use harpoon instead
    -- vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))  -- use harpoon instead
    -- vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split')) -- use harpoon instead
    vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
    vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
    vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
    vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
    vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', 'a', api.fs.create, opts('Create File Or Directory'))
    vim.keymap.set('n', 'bd', api.marks.bulk.delete, opts('Delete Bookmarked'))
    vim.keymap.set('n', 'bt', api.marks.bulk.trash, opts('Trash Bookmarked'))
    vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
    vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle Filter: No Buffer'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Filter: Git Clean'))
    vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
    vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
    vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
    vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
    vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
    vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
    vim.keymap.set('n', 'F', api.live_filter.clear, opts('Live Filter: Clear'))
    vim.keymap.set('n', 'f', api.live_filter.start, opts('Live Filter: Start'))
    vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
    vim.keymap.set('n', 'ge', api.fs.copy.basename, opts('Copy Basename'))
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Filter: Git Ignore'))
    vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
    vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
    vim.keymap.set('n', 'L', api.node.open.toggle_group_empty, opts('Toggle Group Empty'))
    vim.keymap.set('n', 'M', api.tree.toggle_no_bookmark_filter, opts('Toggle Filter: No Bookmark'))
    vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
    vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
    vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
    vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
    vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
    vim.keymap.set('n', 'u', api.fs.rename_full, opts('Rename: Full Path'))
    vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Filter: Hidden'))
    vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
    vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Filter: Git Ignore'))
    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))

    vim.keymap.set('n', '<C-h>', move_previous_and_harpoon, opts('Move to Right Window'))
end

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "ThePrimeagen/harpoon",
    },
    config = function()
        require("nvim-tree").setup {
            sort = {
                sorter = "case_sensitive"
            },
            update_focused_file = {
                enable = true,
            },
            view = {
                width = 40,
                relativenumber = true,
            },
            renderer = {
                group_empty = true
            },
            filters = {},
            on_attach = my_on_attach,
        }

    end
}
