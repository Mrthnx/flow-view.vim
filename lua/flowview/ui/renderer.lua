local M = {}

function M.render(node)
  local lines = {}

  table.insert(lines, string.format("▸ %s()", node.name or "anonymous"))
  if node.uri and node.uri ~= "" then
    table.insert(lines, string.format("  [%s]", node.uri))
  end

  if node.code_lines and #node.code_lines > 0 then
    for _, line in ipairs(node.code_lines) do
      table.insert(lines, "  " .. line)
    end
  end

  return lines
end

return M
