local M = {}

function M.setup()
  vim.api.nvim_set_hl(0, "FlowViewTitle", { link = "Title" })
end

return M
