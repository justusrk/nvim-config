local shared = {}

-- Autogroups
shared.group_justusrk = vim.api.nvim_create_augroup("justusrk", {})

-- Editor Events
shared.group_justusrk_yank_highlight = vim.api.nvim_create_augroup("justusrk_highlight_yank", {});
shared.group_justusrk_buffer_pre_write = vim.api.nvim_create_augroup("justusrk_buffer_pre_write", {});

-- Quickfix
shared.group_justusrk_quickfix_keymaps = vim.api.nvim_create_augroup("justusrk_quickfix_keymaps", {clear = true})

-- Fugutive
shared.group_justusrk_fugitive = vim.api.nvim_create_augroup("justusrk_fugitive", {})

-- Trouble
shared.group_justusrk_trouble_keymaps = vim.api.nvim_create_augroup("justusrk_trouble_keymaps", {clear = true})

-- Lsp
shared.group_justusrk_lsp_config = vim.api.nvim_create_augroup("justusrk_lsp_config", {})


return shared;