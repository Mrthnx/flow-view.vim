local config = require("flowview.config")
local commands = require("flowview.commands")

local M = {}

function M.setup(opts)
  config.setup(opts)
  commands.setup()
end

return M
