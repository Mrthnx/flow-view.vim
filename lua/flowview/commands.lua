local panel = require("flowview.ui.panel")

local M = {}

function M.setup()
  vim.api.nvim_create_user_command("FlowView", function()
    panel.open()
  end, {})
end

return M
