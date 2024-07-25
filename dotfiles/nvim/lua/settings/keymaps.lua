local map = require"util.map"

map("n", "<Space>", "<Nop>", "Mapleader")
vim.g.mapleader = " "

map("n", "<leader>df", vim.diagnostic.open_float, "[D]iagnostics [f]loat")

