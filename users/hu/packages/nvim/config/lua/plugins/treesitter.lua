return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require"nvim-treesitter.configs".setup {
      ensure_installed = "all", -- pipebomb
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    }
  end,
  run = ":TSUpdate",
}
