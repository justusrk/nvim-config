require("nvim-ide.set")
require("nvim-ide.remap")

require("nvim-ide.filetypes")
require("nvim-ide.events")

-- Load Lazy Package Manager
require("nvim-ide.lazy_init")

-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd




