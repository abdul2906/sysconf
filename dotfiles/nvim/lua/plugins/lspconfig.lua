return {
  "neovim/nvim-lspconfig",
  config = function()
    local require_dir = require"util.require_dir"
    local lspees = require_dir(vim.fn.stdpath("config").."/lua/plugins/lsp/", "plugins.lsp")
    for _, lspee in ipairs(lspees) do
      lspee()
    end

    local map = require"util.map"
    local vlb = vim.lsp.buf
    local format = function()
        vlb.format { async = true }
    end
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function()
            map("n", "<leader>lgD", vlb.declaration, "[l]sp [g]o to [D]eclaration")
            map("n", "<leader>lgd", vlb.definition, "[l]sp [g]o to [d]definition")
            map("n", "<leader>lgi", vlb.implementation, "[l]sp [g]o to [i]mplementation")
            map("n", "<leader>lgr", vlb.references, "[l]sp [g]o to [r]eferences")
            map("n", "<leader>lh", vlb.hover, "[l]sp [h]over over selection")
            map("n", "<leader>lfm", format, "[l]sp [f]or[m]at file")
            map("n", "<leader>lca", vlb.code_action, "[l]sp [C]ode [a]ction")
        end,
    })
  end
}

