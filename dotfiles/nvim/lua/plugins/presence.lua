return {
  "vyfor/cord.nvim",
  build = "./build || .\\build",
  event = "VeryLazy",
  config = function()
    require"cord".setup {
      editor = {
        tooltip = "I will escape this meat prison one day.",
      },
      display = {
        show_repository = false,
        show_cursor_position = true,
      },
      lsp = {
        show_problem_count = true,
        severity = 2,
      },
    }
  end
}
