return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    {
      "tamago324/cmp-zsh",
      config = function()
        require"cmp_zsh".setup {
          zshrc = true,
          filetypes = { "bash", "zsh", "sh" },
        }
      end,
    },
    "ray-x/cmp-treesitter",
    "hrsh7th/cmp-nvim-lua",
    "andersevenrud/cmp-tmux",
  },
  config = function()
    local cmp = require"cmp"
    cmp.setup {
      snippet = {
        expand = function(args)
          require"luasnip".lsp_expand(args.body)
        end,
      },
      view = {
        entries = "native",
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-k>']     = cmp.mapping.select_prev_item(),
        ['<C-j>']     = cmp.mapping.select_next_item(),
        ['<A-j>']     = cmp.mapping.scroll_docs(4),
        ['<A-k>']     = cmp.mapping.scroll_docs(-4),
        ['<S-CR>']    = cmp.mapping.complete(),
        ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>']     = cmp.mapping.abort(),
      },
      sources = {
        { name = "path" },
        { name = "luasnip" },
        { name = "zsh" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "treesitter" },
        { name = "nvim-lua" },
        { name = "tmux" },
      },
    }
  end
}

