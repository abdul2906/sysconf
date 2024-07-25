if vim.fn.executable("git") ~= 1 then
  vim.notify("git is not installed. Skipping plugins.", vim.log.levels.WARN)
  return
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

plugins = require"util.require_dir"(vim.fn.stdpath("config").."/lua/plugins/", true)

require"lazy".setup(plugins)

