return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require"telescope".setup {}

    local tb = require"telescope.builtin"
    local map = require"util.map"

    -- Default pickers
    map("n", "<leader>tf", function()
      if vim.fn.isdirectory(".git") ~= 0 then
        tb.git_files()
      else
        tb.find_files()
      end
    end, "[T]elescope [f]iles")
    map("n", "<leader>tg", tb.live_grep, "[T]elescope [g]rep")
    map("n", "<leader>tb", tb.buffers, "[T]elescope [b]uffers")
    map("n", "<leader>tm", function()
      tb.man_pages({ "ALL" })
    end, "[T]elescope [m]an pages")
    map("n", "<leader>tk", tb.keymaps, "[T]elescope [k]eymaps")
    map("n", "<leader>tk", tb.keymaps, "[T]elescope [k]eymaps")

    -- LSP pickers
    map("n", "<leader>tld", tb.diagnostics, "[T]elescope [l]sp [d]iagnostics")
    map("n", "<leader>tlr", tb.lsp_references, "[T]elescope [l]sp [r]eferences")
  end,
}
