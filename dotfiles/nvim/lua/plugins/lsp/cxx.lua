return function ()
  require"lspconfig".clangd.setup {
    capabilities = require"cmp_nvim_lsp".default_capabilities(),
    filetypes = {
      "cpp", "objc", "objcpp", "cuda", "proto"
    }
  }
end
