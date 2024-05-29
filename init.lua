-- Check if running inside VS Code
if vim.g.vscode then
    -- Neovim in VS Code specific settings
    -- print("Running inside VS Code")
    -- Adjust settings or disable plugins
    require('justusrk-vscode')
else
    -- Standalone Neovim specific settings
    -- print("Running standalone Neovim")
    require('theprimeagen')
    -- Load standalone specific plugins or settings
end
