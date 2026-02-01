local config = require("flowview.config")
local builder = require("flowview.graph.builder")
local renderer = require("flowview.ui.renderer")

local M = {}

local function ensure_buffer()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "flowview"
  vim.bo[buf].modifiable = false
  return buf
end

local function populate(buf)
  local stub = builder.build_stub()
  local lines = {
    "FlowView",
    string.rep("─", 30),
  }
  local rendered = renderer.render(stub)
  for _, line in ipairs(rendered) do
    table.insert(lines, line)
  end

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  vim.api.nvim_buf_add_highlight(buf, 0, "FlowViewTitle", 0, 0, -1)
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
