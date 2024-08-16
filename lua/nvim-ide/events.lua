local autocmd = vim.api.nvim_create_autocmd
local shared = require('common.shared')

-- Before Saving the buffer Remove Trailing Space from each line
autocmd({"BufWritePre"}, {
    group = shared.group_justusrk_buffer_pre_write,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Disable folding in Telescope's result window.
autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })