local M = {}

function M.get_lines(bufnr, start_line, end_line)
  return vim.api.nvim_buf_get_lines(bufnr, start_line, end_line, false)
end

return M
