local shared = {}

-- Autogroups
shared.group_justusrk = vim.api.nvim_create_augroup("justusrk", {})

-- Editor Events
shared.group_justusrk_yank_highlight = vim.api.nvim_create_augroup("justusrk_highlight_yank", {});
shared.group_justusrk_buffer_pre_write = vim.api.nvim_create_augroup("justusrk_buffer_pre_write", {});

-- Fugutive
shared.group_justusrk_fugitive = vim.api.nvim_create_augroup("justusrk_fugitive", {})


return shared;