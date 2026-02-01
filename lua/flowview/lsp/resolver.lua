local M = {}

function M.resolve_call(_params, on_complete)
  if on_complete then
    on_complete({})
  end
end

return M
