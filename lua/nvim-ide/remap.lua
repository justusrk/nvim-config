-- <leader> is <Space>
vim.g.mapleader = " "

-- Open File Explorer
-- We are using NvimTree for file explorer so disable for now
-- vim.keymap.set("n", "<leader>fv", vim.cmd.Ex) 

-- Move lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join line while keeping cursor in the same position
vim.keymap.set("n", "J", "mzJ`z")

-- Scroll the screen down and up and center cursor in screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Next and Previous search results
-- n / N  : next / previous search result
-- zz will center
-- zv will keep the cursor in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without overwriting the clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank/Copy to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]]) -- yank to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- yank entire line to system clipboard

-- Delete to the blackhole register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "<leader>D", [["_D]])

-- C-c acts more like cancel while Esc behaves more like back - they have slight differences in some cases
-- We want <C-c> to behave like escape in these fringe cases
vim.keymap.set("i", "<C-c>", "<Esc>")


------------------------
-- Inside Neovim Only -- 

-- Open File Explorer
vim.keymap.set("n", "<leader>fv", ":NvimTreeToggle<CR>") -- file view

-- Search and Replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>fafx", "<cmd>!chmod +x %<CR>", {
    silent = true
})

-- Saving Files
vim.keymap.set('n', '<D-s>', ':wa<CR>') -- Save all files
vim.keymap.set('i', '<D-s>', '<Esc>:wa<CR>') -- Save all files
vim.keymap.set("v", "<D-s>", "<Esc>:wa<CR>gv") -- Save all files
vim.keymap.set("n", "<M-s>", ":w<CR>") -- save current file
vim.keymap.set("i", "<M-s>", "<Esc>:w<CR>a") -- save current file
vim.keymap.set("v", "<M-s>", "<Esc>:w<CR>gv") -- save current file

-- Copy
vim.keymap.set('v', '<D-c>', '"+y') -- Copy

-- Paste
-- vim.keymap.set('', '<D-v>', '"+P', { noremap = true, silent = true}) -- Paste in normal (n), visual (v), select (x), and operator-pending (o) modes.
vim.keymap.set('n', '<D-v>', '"+p', { noremap = true, silent = true})
vim.keymap.set('v', '<D-v>', '"+p', { noremap = true, silent = true})
-- vim.keymap.set('!', '<D-v>', '<C-R>+', { noremap = true, silent = true}) -- Paste in insert and command line modes
vim.keymap.set('c', '<D-v>', '<C-R>+', { noremap = true, silent = true }) -- Paste in command mode
vim.keymap.set('i', '<D-v>', '<C-R>+', { noremap = true, silent = true }) -- Paste in insert mode
vim.keymap.set('t', '<D-v>', '<C-R>+', { noremap = true, silent = true}) -- Paste in terminal mode


-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so") -- source file - maybe we need to specify the file to source
-- end)

-- Fold keymaps
-- Function to move to the previous outer fold above
local function fold_goto_upper_outer_fold()
    local current_line = vim.fn.line('.')
    local current_fold_level = vim.fn.foldlevel(current_line)
    local current_col = vim.fn.col('.')
    
    -- Move up until we find a line with a lower fold level
    for lnum = current_line - 1, 1, -1 do
      if vim.fn.foldlevel(lnum) < current_fold_level then
        vim.fn.cursor(lnum, current_col)
        return
      end
   end
end

-- Function to move to the next inner fold below
local function fold_goto_down_inner_fold() 
    local current_line = vim.fn.line('.')
    local current_fold_level = vim.fn.foldlevel(current_line)
    local current_col = vim.fn.col('.')
    local line_count = vim.fn.line('$')
    
    -- Move down until we find a line with a lower fold level
    for lnum = current_line + 1, line_count, 1 do
      if vim.fn.foldlevel(lnum) > current_fold_level then
        vim.fn.cursor(lnum, current_col)
        return
      end
   end
end

local function fold_goto_fold_same_level(dir)
    local current_fold_level = vim.fn.foldlevel('.')
    local current_col = vim.fn.col('.')
    local line_count 
    if dir == 1 then
        line_count = vim.fn.line('$') 
    elseif dir == -1 then
        line_count = 1
    end
    for lnum = vim.fn.line('.') + dir, line_count, dir do
      if vim.fn.foldlevel(lnum) == current_fold_level then
        vim.fn.cursor(lnum, current_col)
        return
      end
    end
end

vim.keymap.set('n', 'ZO', fold_goto_upper_outer_fold, {noremap = true, silent = true, desc = "Go to outer fold" })
vim.keymap.set('n', 'ZI', fold_goto_down_inner_fold, {noremap = true, silent = true, desc = "Go to inner fold" })
vim.keymap.set('n', 'ZJ', function() fold_goto_fold_same_level(1) end, {noremap = true, silent = true, desc = "Go to next fold of same level" })
vim.keymap.set('n', 'ZK', function() fold_goto_fold_same_level(-1) end, {noremap = true, silent = true, desc = "Go to previous fold of same level" })
vim.keymap.set('n', 'Za', 'za', {noremap = true, silent = true, desc = "Toggle fold under cursor" })
vim.keymap.set('n', 'ZA', 'zA', {noremap = true, silent = true, desc = "Toggle all fold under cursor" })
vim.keymap.set('n', 'ZM', 'zM', {noremap = true, silent = true, desc = "Close all folds" })
vim.keymap.set('n', 'ZR', 'zR', {noremap = true, silent = true, desc = "Open all folds" })


-- Quickfix and Locallist --
local function toggle_quickfix()
    local qf_winid = vim.fn.getqflist({
        winid = 0
    }).winid
    if qf_winid > 0 then
        vim.cmd('cclose')
    else
        vim.cmd('copen')
    end
end
vim.keymap.set('n', '<leader>q', toggle_quickfix, {
    desc = 'Toggle Quickfix Window'
})

local function toggle_locallist()
    local ll_winid = vim.fn.getloclist(0, {
        winid = 0
    }).winid
    if ll_winid > 0 then
        vim.cmd('lclose')
    else
        local success, error_msg = pcall(vim.cmd, 'lopen')
        if not success then
            print(error_msg)
        end
    end
end
vim.keymap.set('n', '<leader>l', toggle_locallist, {
    desc = 'Toggle Locallist Window'
})

-- Key bind for quickfix and locallist window to goto location on Enter
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        local qf_winid = vim.fn.getqflist({
            winid = 0
        }).winid
        local ll_winid = vim.fn.getloclist(0, {
            winid = 0
        }).winid
        local current_window = vim.api.nvim_get_current_win()
        if qf_winid == current_window then -- check if current buffer window is qf_winid
            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", ":.cc<CR>", {
                silent = true,
                noremap = true
            })
        elseif ll_winid == current_window then -- check if current buffer window is ll_winid
            vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", ":.ll<CR>", {
                silent = true,
                noremap = true
            })
        end 
    end
})
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz") -- quickfix next (global files)
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz") -- quickfix previous (global files)
vim.keymap.set("n", "<C-S-j>", "<cmd>lnext<CR>zz") -- location list next (local to the current buffer)
vim.keymap.set("n", "<C-S-k>", "<cmd>lprev<CR>zz") -- location list previous (local to the current buffer)
-- --- -- 

-- vim.keymap.set("n", "Q", "<nop>") -- play last recorded macro
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format) -- format code

-- Command Line Mode Remaps
-- <C-w> to delete the word before the cursor
-- <C-u> to delete the line from beginning upto the cursor
-- <C-f> open command-line window with the command-line history
--      <C-c> in command-line window to choose the command from the history
-- <C-c> in command line to cancel the command-line mode
-- <C-r>[r] in command-line mode insert the contents of a register 
--      [r] [r = + , r = *] for system clipboard, [r = "] for the default register
-- <C-r><C-a> in command-line mode insert the word under the cursor
-- <C-r><C-l> in command-line mode insert the line under the cursor
-- <C-r><C-w> in command-line mode insert the word under the cursor
-- <C-p> in command-line mode to select the previous command executed
-- <C-n> in command-line mode to select the next command executed
-- cannot map C-i because it is used for tab complete
vim.api.nvim_set_keymap('c', '<C-a>', '<Home>', {noremap = true}) -- move to the beginning of the line
vim.api.nvim_set_keymap('c', '<C-s>', '<End>', {noremap = true}) -- move to the end of the line
-- vim.api.nvim_set_keymap('c', '<C-k>', '<Up>', {noremap = true}) -- move up (no use in command mode?)
-- vim.api.nvim_set_keymap('c', '<C-j>', '<Down>', {noremap = true}) -- move down (no use in command mode?)
vim.api.nvim_set_keymap('c', '<C-j>', '<Left>', {noremap = true}) -- move left
vim.api.nvim_set_keymap('c', '<C-k>', '<Right>', {noremap = true}) -- move right
vim.api.nvim_set_keymap('c', '<C-h>', '<BS>', {noremap = true}) -- backspace : delete character to left
vim.api.nvim_set_keymap('c', '<C-l>', '<Del>', {noremap = true}) -- delete : delete character to right
vim.api.nvim_set_keymap('c', '<C-b>', '<S-Left>', {noremap = true}) -- move to the beginning of the previous word
vim.api.nvim_set_keymap('c', '<C-e>', '<S-Right>', {noremap = true}) -- move to the end of the next word

-- Terminal Keymaps
vim.api.nvim_set_keymap('t', '<C-[>', '<C-\\><C-n>', {noremap = true, silent = true}) -- enter normal mode
vim.api.nvim_set_keymap('t', '<C-w>j', [[<Cmd>wincmd j<CR>]], {noremap = true , silent = true}) -- move to window below
vim.api.nvim_set_keymap('t', '<C-w>k', [[<Cmd>wincmd k<CR>]], {noremap = true, silent = true}) -- move to window above
vim.api.nvim_set_keymap('t', '<C-w>h', [[<Cmd>wincmd h<CR>]], {noremap = true , silent = true}) -- move to window left
vim.api.nvim_set_keymap('t', '<C-w>l', [[<Cmd>wincmd l<CR>]], {noremap = true , silent = true}) -- move to window right


-- Copilot Keymaps
vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-dismiss)')
vim.keymap.set('i', '<M-Bslash>', '<Plug>(copilot-suggest)')
vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<M-->', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<M-=>', '<Plug>(copilot-accept-line)')


-- Make it Rain Cellular Automaton Relax --
vim.keymap.set("n", "<leader>zmr", "<cmd>CellularAutomaton make_it_rain<CR>");



-- Autocmd Keymaps
local shared = require('common.shared')
local autocmd = vim.api.nvim_create_autocmd

-- Quickfix and Locallist only keymaps
-- TODO: handle location list 
local function convert_to_trouble()
    vim.g.justusrk_last_trouble_mode = "my_quickfix"
    vim.cmd('cclose')
    vim.cmd('Trouble my_quickfix open focus=true')
end

vim.api.nvim_create_autocmd('FileType', {
    group = shared.group_justusrk_quickfix_keymaps,
    pattern = 'qf',
    callback = function()
      -- Set the keymap for quickfix buffers
      -- To convert quickfix to trouble
      vim.g.justusrk_last_trouble_mode = "my_quickfix"
      vim.keymap.set('n', '<C-t>', convert_to_trouble, {buffer=0, noremap = true, silent = true, desc = "Convert Quickfix to Trouble" })
    end
})

-- Trouble Keymaps

local trouble_jump_when_modes = { -- for custom modes look in trouble's setup config
    "my_diagnostics_local",
    "my_diagnostics_global",
    -- "my_quickfix",
    -- "my_loclist",
}

local function trouble_jump_next()
    local mode = vim.g.justusrk_last_trouble_mode or default_mode
    vim.cmd('Trouble ' .. mode .. ' next')
    if vim.tbl_contains(trouble_jump_when_modes, mode) then
      vim.cmd('Trouble ' .. mode .. ' jump')
    end
end
local function trouble_jump_previous()
    local mode = vim.g.justusrk_last_trouble_mode or default_mode
    vim.cmd('Trouble ' .. mode .. ' prev')
    if vim.tbl_contains(trouble_jump_when_modes, mode) then
      vim.cmd('Trouble ' .. mode .. ' jump')
    end
end

vim.api.nvim_create_autocmd('FileType', {
    group = shared.group_justusrk_trouble_keymaps,
    pattern = 'Trouble',
    callback = function()
      -- Set the keymap for trouble buffers
      -- prevent convert quickfix jump in trouble -- gives an error bug in trouble : Cursor position outside buffer
      vim.keymap.set('n', '<C-j>', trouble_jump_next, {buffer=0, noremap = true, silent = true, desc = "Trouble jump to next item" })
      vim.keymap.set('n', '<C-k>', trouble_jump_previous, {buffer=0, noremap = true, silent = true, desc = "Trouble jump to previous item" })
    end
})


local function load_trouble_keymaps() 
    local default_mode = "diagnostics"
    vim.g.justusrk_last_trouble_mode = default_mode;
    -- jump only for certain modes on next and prev
    
    opts = { noremap = true, silent = true, desc = "Trouble Keymaps" }

    opts.desc = "Trouble toggle list diagnostics for current file"
    vim.keymap.set("n", "<leader>td", function() -- diag only current file
        local mode = "my_diagnostics_local"
        vim.g.justusrk_last_trouble_mode = mode
        vim.cmd('Trouble ' .. mode .. ' toggle')
    end, opts)
    
    opts.desc = "Trouble toggle list diagnostics for all open buffers"
    vim.keymap.set("n", "<leader>tD", function() -- diag all open files
        local mode = "my_diagnostics_global"
        vim.g.justusrk_last_trouble_mode = mode
        vim.cmd('Trouble ' .. mode .. ' toggle')
    end, opts)

    opts.desc = "Trouble toggle quickfix"
    vim.keymap.set("n", "<leader>tq", function()
        local mode = "my_quickfix"
        vim.g.justusrk_last_trouble_mode = mode
        vim.cmd('Trouble ' .. mode .. ' toggle')
    end, opts)
    
    
    opts.desc = "Trouble toggle locallist"
    vim.keymap.set("n", "<leader>tl", function()
        local mode = "my_loclist"
        vim.g.justusrk_last_trouble_mode = mode
        vim.cmd('Trouble ' .. mode .. ' toggle')
    end, opts)
    
    opts.desc = "Trouble toggle last mode"
    vim.keymap.set("n", "<leader>tt", function()
        local mode = vim.g.justusrk_last_trouble_mode or default_mode
        vim.cmd('Trouble ' .. mode .. ' toggle')
    end, opts)
    
    opts.desc = "Trouble go to next item"
    vim.keymap.set("n", "<D-j>", trouble_jump_next, opts)
    
    opts.desc = "Trouble go to previous item"
    vim.keymap.set("n", "<D-k>", trouble_jump_previous, opts)
end

load_trouble_keymaps()

-- Upon LspAttach set some keymaps only for files supported by LSP

-- Function to list type definitions and handle multiple results
local function fetch_lsp_list(req)
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, req, params, 
        function(err, result, ctx, _)
          if err then
            vim.notify('Error: ' .. err.message, vim.log.levels.ERROR)
            return
          end
          if not result or vim.tbl_isempty(result) then
            vim.notify('No type definitions found', vim.log.levels.INFO)
            return
          end
          -- if #result == 1 then -- automatically jump there if only one location
          --   vim.lsp.util.jump_to_location(result[1])
          -- else
          local locations = vim.lsp.util.locations_to_items(result, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
          vim.fn.setqflist(locations)
          vim.api.nvim_command('copen')
        end
    )
end


autocmd('LspAttach', {
    group = shared.group_justusrk_lsp_config,
    callback = function(e)
        local opts = { buffer = e.buf, silent = true }

        opts.desc = "Go to definition of symbol under cursor"
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts) -- use the default vim gd (goto definition)

        opts.desc = "Go to declaration of symbol under cursor"
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts) -- use the default vim gD (goto declaration)

        opts.desc = "Display documentation for symbol under cursor"
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts) -- use the default K (show information in hover)
        
        opts.desc = "Displays signature information about the symbol under the cursor"
        vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end, opts) -- open signature help floating window

        opts.desc = "Search for symbols in the workspace"
        vim.keymap.set("n", "<leader>cws", function() vim.lsp.buf.workspace_symbol() end, opts) -- search for symbols in the workspace
        
        opts.desc = "Opens a floating window with diagnostic information"
        vim.keymap.set("n", "<leader>cd", function() vim.diagnostic.open_float() end, opts) -- open the diagnostic message floating window
        

        opts.desc = "Code action rename symbol under cursor"
        vim.keymap.set("n", "<leader>car", function() vim.lsp.buf.rename() end, opts) -- code action rename 

        opts.desc = "Code format "
        vim.keymap.set("n", "<leader>caf", function() vim.lsp.buf.format() end, opts) -- code action format 
        
        
        opts.desc = "List available code actions at current cursor position"
        vim.keymap.set({"n", "v"}, "<leader>cla", function() vim.lsp.buf.code_action() end, opts) -- code action to do things like import missing modules etc..

        opts.desc = "List references of symbol under cursor"
        vim.keymap.set("n", "<leader>clr", function() vim.lsp.buf.references() end, opts) -- code list references
        
        opts.desc = "List implementations of symbol under cursor"
        vim.keymap.set("n", "<leader>cli", function() vim.lsp.buf.implementation() end, opts) -- code list implementations

        opts.desc = "List definitions of symbol under cursor"        
        vim.keymap.set("n", "<leader>cld", function() list_type_definitions('textDocument/definition') end, opts) -- list lsp definitions

        opts.desc = "List declarations of symbol under cursor"        
        vim.keymap.set("n", "<leader>clD", function() list_type_definitions('textDocument/declaration') end, opts) -- list declarations
        
        opts.desc = "List type definitions of symbol under cursor"
        vim.keymap.set("n", "<leader>clt", function() list_type_definitions('textDocument/typeDefinition') end, opts) -- list lsp type definitions



        opts.desc = "Go to next diagnostic message"
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts) -- next diagnostic message

        opts.desc = "Go to previous diagnostic message"
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts) -- previous diagnostic message
        
        -- trouble keymaps
        opts.desc = "List LSP definitions, references, implementations, type definitions, and declarations "
        vim.keymap.set("n", "<leader>cll", 
            function() 
                local mode = "my_lsp"
                vim.g.justusrk_last_trouble_mode = mode
                vim.cmd('Trouble ' ..mode .. ' toggle  focus=false') 
            end, 
        opts) -- lsp List LSP definitions, references, implementations, type definitions, and declarations 
        
        opts.desc = "List document symbols"
        vim.keymap.set("n", "<leader>cls", 
            function() 
                local mode = "my_symbols"
                vim.g.justusrk_last_trouble_mode = mode
                vim.cmd('Trouble ' ..mode .. ' toggle  focus=false') 
            end,
        opts) -- lsp symbols
    end
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = shared.group_justusrk,
    pattern = "*",
    callback = function(e)
        local opts = { buffer = e.buf }
    end
  })

