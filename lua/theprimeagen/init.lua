require("theprimeagen.set")
require("theprimeagen.remap")

require("theprimeagen.lazy_init")

-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
    group = ThePrimeagenGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts) -- use the default vim gd (goto definition)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts) -- use the default K (show information in hover)
        vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end, opts) -- open signature help floating window
        vim.keymap.set("n", "<leader>cws", function() vim.lsp.buf.workspace_symbol() end, opts) -- search for symbols in the workspace
        vim.keymap.set("n", "<leader>cd", function() vim.diagnostic.open_float() end, opts) -- open the diagnostic message floating window
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts) -- code action to do things like import missing modules etc..
        vim.keymap.set("n", "<leader>crr", function() vim.lsp.buf.references() end, opts) -- list references
        vim.keymap.set("n", "<leader>crn", function() vim.lsp.buf.rename() end, opts) -- rename symbol
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    end
})


vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
