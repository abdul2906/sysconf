return function()
  require"lspconfig".basedpyright.setup {
    settings = {
      python = {
        pythonPath = vim.fn.exepath("python3"),
      },
    },
  }
end

