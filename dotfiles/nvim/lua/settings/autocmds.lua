vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.h",
  callback = function()
    -- Toggle .h files between being interpreted as C and C++
    -- in case I have to work on a C++ header that was saved
    -- (incorrectly) as a C header file.
    vim.api.nvim_create_user_command("Fytwmmrt", function()
      if not vim.b.fu then
        vim.b.fu = true
        vim.bo.filetype = "cpp"
        vim.cmd([[
          LspStop ccls 
          LspStart clangd 
        ]])
      else
        vim.b.fu = false
        vim.bo.filetype = "c"
        vim.cmd([[
          LspStop ccls 
          LspStart clangd 
        ]])
      end
    end, { desc = "Fuck you to whoever made me run this."})

    -- Set all .h files to be interpreted as C by default instead
    -- of C++. If you use .h for your C++ headers instead of .hpp
    -- you should be ashamed of yourself and change and grow as a
    -- person as to not repeat such heretical offenses.
    if not vim.b.fu then
      vim.bo.filetype = "c"
      vim.cmd([[
        LspStop clangd
        LspStart ccls
      ]])
    end
  end,
})
