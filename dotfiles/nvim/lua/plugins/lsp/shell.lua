return function()
  require"lspconfig".bashls.setup {
    capabilities = require"cmp_nvim_lsp".default_capabilities(),
  }
end
