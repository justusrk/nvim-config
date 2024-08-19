local autocmd = vim.api.nvim_create_autocmd

-- Add File Types
-- Templ is a file type that i use for templating HMTML using Go
-- vim.filetype.add({
--     extension = {
--         templ = 'templ',
--     }
-- })

-- Disable folding in Telescope's result window.
autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })