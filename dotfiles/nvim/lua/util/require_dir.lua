return function(dir, skip_init)
  local returns = {}
  local lua_files = vim.split(vim.fn.glob(dir.."/*.lua"), "\n")
  local namespace = string.gsub(dir, vim.fn.stdpath("config").."/lua/", "")
  namespace = string.gsub(namespace, "%/", ".")

  for _, file in ipairs(lua_files) do
    file = string.gsub(file, "%.lua", "")
    file = string.gsub(file, dir.."/", namespace)

    if skip_init and file == namespace.."init" then
      goto continue
    end

    local require_ok, require_return = pcall(require, file)
    if require_ok then
      table.insert(returns, require_return)
    else
      vim.notify("Could not require file: '"..file.."': "..require_return, vim.log.levels.WARNING)
    end

    ::continue::
  end

  return returns
end

