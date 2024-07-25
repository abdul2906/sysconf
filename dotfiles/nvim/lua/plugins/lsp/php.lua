return function ()
  require"lspconfig".intelephense. setup {
    capabilities = require"cmp_nvim_lsp".default_capabilities(),
  }
end
