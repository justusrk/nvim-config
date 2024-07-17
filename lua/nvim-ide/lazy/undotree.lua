-- Undo history tree -- now you can time travel your code changes
return {
    "mbbill/undotree",

    config = function() 
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
}

