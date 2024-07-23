-- For commenting out code
return {
    'numToStr/Comment.nvim',
    dependencies = {
        {
            'JoosepAlviste/nvim-ts-context-commentstring', -- for commenting tsx or jsx
            config = function() 
                require('ts_context_commentstring').setup {
                    enable_autocmd = false,
                  }
            end
        }
    },
    opts = {
        -- add any options here
    },
    config = function() 
        require('Comment').setup {
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(), -- for tsx or jsx
        }
    end,
    lazy = false,
}