return function(mode, key, mapping, comment)
    local opts = {
        noremap = true,
        silent = true,
        desc = comment
    }
    vim.keymap.set(mode, key, mapping, opts)
end

