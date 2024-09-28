return function ()
  require"lspconfig".ts_ls.setup {
    capabilities = require"cmp_nvim_lsp".default_capabilities()
  }
end
