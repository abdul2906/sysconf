return function()
  require"lspconfig".rust_analyzer.setup {
    settings = {
      ["rust-analyzer"] = {
        diagnostics = {
          enable = false,
        },
      },
    },
  }
end
