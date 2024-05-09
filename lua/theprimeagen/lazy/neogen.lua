-- For generating annotations and comments for documentation
return {
    "danymat/neogen",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local neogen = require("neogen")

        neogen.setup({
            snippet_engine = "luasnip"
        })

        vim.keymap.set("n", "<leader>cnf", function()
            neogen.generate({ type = "func" })
        end)

        vim.keymap.set("n", "<leader>cnt", function()
            neogen.generate({ type = "type" })
        end)

    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
}

