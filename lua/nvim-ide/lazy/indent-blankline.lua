-- For highlighting indents and whitespace
local highlight = {
    "CursorColumn",
    "Whitespace",
}
return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function ()
        require("ibl").setup {
        }
    end
}
