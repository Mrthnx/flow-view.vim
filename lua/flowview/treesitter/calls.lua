local queries = require("flowview.treesitter.queries")

local M = {}

function M.extract_calls(_bufnr, language)
  return queries.queries[language] and {} or {}
end

return M
