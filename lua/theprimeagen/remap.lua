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
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

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
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {
    silent = true
})

-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so") -- source file - maybe we need to specify the file to source
-- end)


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
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz") -- location list next (local to the current buffer)
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz") -- location list previous (local to the current buffer)
-- --- -- 

-- vim.keymap.set("n", "Q", "<nop>") -- play last recorded macro
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format) -- format code

-- Command Mode Remaps
-- <C-w> to delete the word before the cursor
-- <C-u> to delete the line from beginning upto the cursor
-- <C-f> open command-line window with the command-line history
-- <C-c> in command-line window to choose the command from the history
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

-- Copilot Keymaps
vim.keymap.set('i', '<C-\\>', '<Plug>(copilot-dismiss)')
vim.keymap.set('i', '<M-\\>', '<Plug>(copilot-suggest)')
vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<M-+>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<M-=>', '<Plug>(copilot-accept-line)')


-- Make it Rain Cellular Automaton Relax --
vim.keymap.set("n", "<leader>zmr", "<cmd>CellularAutomaton make_it_rain<CR>");