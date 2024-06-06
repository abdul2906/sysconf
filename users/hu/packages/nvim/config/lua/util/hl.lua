return function (name)
  local hl = vim.api.nvim_get_hl(0, { name = name })  
  while hl.link ~= nil do
    hl = vim.api.nvim_get_hl(0, { name = hl.link })
  end
  return hl
end
