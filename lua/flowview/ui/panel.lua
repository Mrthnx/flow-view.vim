local config = require("flowview.config")

local M = {}

local function ensure_buffer()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "flowview"
  vim.bo[buf].modifiable = false
  return buf
end

local function populate(buf)
  local lines = {
    "FlowView (MVP scaffold)",
    string.rep("─", 30),
    "Waiting for flow graph...",
  }
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
end

function M.open()
  local width = config.options.panel_width
  vim.cmd("vsplit")
  vim.cmd("vertical resize " .. width)
  local buf = ensure_buffer()
  vim.api.nvim_win_set_buf(0, buf)
  populate(buf)
end

return M
