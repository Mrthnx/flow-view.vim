local M = {}

function M.new(data)
  return {
    id = data.id,
    name = data.name,
    uri = data.uri,
    range = data.range,
    language = data.language,
    code_lines = data.code_lines or {},
    calls = data.calls or {},
  }
end

return M
