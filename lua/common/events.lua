local autocmd = vim.api.nvim_create_autocmd
local shared = require('common.shared')

-- After Yanking Highlight the text for 80ms
autocmd('TextYankPost', {
    group = shared.group_justusrk_yank_highlight,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 50,
        })
    end,
})