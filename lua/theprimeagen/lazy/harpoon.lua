-- For quick accessing files
return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end) -- show harpoon menu
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end) -- add current file to harpoon
        vim.keymap.set("n", "<leader>hh", function() harpoon:list():replace_at(1) end)
        vim.keymap.set("n", "<leader>hj", function() harpoon:list():replace_at(2) end)
        vim.keymap.set("n", "<leader>hk", function() harpoon:list():replace_at(3) end)
        vim.keymap.set("n", "<leader>hl", function() harpoon:list():replace_at(4) end)
        vim.keymap.set("n", "<leader>hg", function() harpoon:list():replace_at(5) end)
        vim.keymap.set("n", "<leader>hf", function() harpoon:list():replace_at(6) end)
        vim.keymap.set("n", "<leader>hd", function() harpoon:list():replace_at(7) end)
        vim.keymap.set("n", "<leader>hs", function() harpoon:list():replace_at(8) end)
        
        harpoon:extend({
            UI_CREATE = function(cx)
                vim.keymap.set("n", "<C-v>", function()
                    harpoon.ui:select_menu_item({ vsplit = true })
                end, { buffer = cx.bufnr })
            
                vim.keymap.set("n", "<C-x>", function()
                harpoon.ui:select_menu_item({ split = true })
                end, { buffer = cx.bufnr })
            
                vim.keymap.set("n", "<C-t>", function()
                    harpoon.ui:select_menu_item({ tabedit = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, {buffer = cx.bufnr, noremap = true, silent = true})
                vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, {buffer = cx.bufnr, noremap = true, silent = true})
                vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, {buffer = cx.bufnr, noremap = true, silent = true})
                vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, {buffer = cx.bufnr, noremap = true, silent = true})
                vim.keymap.set("n", "<C-g>", function() harpoon:list():select(5) end, {buffer = cx.bufnr, noremap = true, silent = true})
                vim.keymap.set("n", "<C-f>", function() harpoon:list():select(6) end, {buffer = cx.bufnr, noremap = true, silent = true})
                vim.keymap.set("n", "<C-d>", function() harpoon:list():select(7) end, {buffer = cx.bufnr, noremap = true, silent = true})
                vim.keymap.set("n", "<C-s>", function() harpoon:list():select(8) end, {buffer = cx.bufnr, noremap = true, silent = true})
                vim.keymap.set("n", "<C-c>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {buffer = 0, noremap = true, silent = true})
            end,
          })
        -- more bindings in init.lua - attached only to the harpoon buffer

    end
}