local options = {
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  expandtab = true,
  number = true,
  relativenumber = true,
  fileencoding = "utf-8",
  cursorline = true,
  wrap = false,
  signcolumn = "yes",
  swapfile = false,
  errorbells = false,
  undofile = true,
  incsearch = true,
  hlsearch = false,
  backup = false,
}

for option, value in pairs(options) do
  pcall(function()
    vim.opt[option] = value
  end)
end

