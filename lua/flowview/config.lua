local M = {}

M.defaults = {
  panel_width = 50,
  max_depth = 3,
}

M.options = vim.deepcopy(M.defaults)

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M
