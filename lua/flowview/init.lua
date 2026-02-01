local config = require("flowview.config")
local commands = require("flowview.commands")
local highlights = require("flowview.ui.highlights")

local M = {}

function M.setup(opts)
  config.setup(opts)
  highlights.setup()
  commands.setup()
end

return M
