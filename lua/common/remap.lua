-- <leader> is <Space>
vim.g.mapleader = " "

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




