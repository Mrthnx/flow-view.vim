local node = require("flowview.graph.node")

local M = {}

function M.build_stub()
  return node.new({
    id = 1,
    name = "stub",
    uri = "",
    range = {},
    language = "",
    code_lines = {
      "-- flow graph coming soon",
    },
    calls = {},
  })
end

return M
