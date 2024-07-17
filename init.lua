-- Common neovim settings applied always
require('common')

-- function to check if running in an external ide like VSCode, XCode, Android Studio, IntelliJ etc..
-- currently only checks if it is VSCode 
local function isExternalIDE()
    return vim.g.vscode
end


-- Check if running inside an IDE 
if not isExternalIDE() then
    -- Load full blown IDE features for Neovim like lsp, treesitter, telescope etc..
    -- Stolen from Primeagen and then modified for users with lower brain power
    require('nvim-ide')
end

if isExternalIDE() then
    -- Load external IDE specific settings
    -- these settings are for external IDEs 
    -- these usually help for modifying text in the IDE
    -- for example: nvim-surround, nvim-comment etc..
    require('external-ide')
end

-- Neovide specific settings
if vim.g.neovide then
    -- Load Neovide specific settings
    require('neovide')
end

