local M = {}

-- Function to create a folder if it doesn't exist
function M.create_directory_if_not_exists(directory)
  directory = vim.fn.expand(directory)
  local uv = vim.loop
  local stat = uv.fs_stat(directory)
  if not stat then
    -- Directory does not exist, create it
    uv.fs_mkdir(directory, 493) -- 493 is 0755 in octal, which means rwxr-xr-x
    print("Created directory: " .. directory)
  else
    print("Directory already exists: " .. directory)
  end
end

return M
