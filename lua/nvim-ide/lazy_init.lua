require('utilities.lazy_install');

require("lazy").setup({
    spec = { 
        { import = "nvim-ide.lazy" },
        { import = "nvim-ide.lazy.lsp" }
    },
    change_detection = { notify = false }
})
