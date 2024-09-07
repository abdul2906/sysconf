return function ()
  require"lspconfig".ccls.setup {
    capabilities = require"cmp_nvim_lsp".default_capabilities()
  }
end
