return function ()
  require"lspconfig".nil_ls.setup {
    capabilities = require"cmp_nvim_lsp".default_capabilities()
  }
end

