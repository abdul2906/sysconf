return function ()
  require"lspconfig".texlab.setup {
    capabilities = require"cmp_nvim_lsp".default_capabilities()
  }
end
