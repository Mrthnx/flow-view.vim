local M = {}

function M.render(node)
  return {
    string.format("%s (%s)", node.name, node.uri or "unknown"),
  }
end

return M
