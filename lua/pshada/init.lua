local M = {}

local utils = require("pshada.utils")
local cmd = require("pshada.cmd")

--- @class Opts
--- @field root_markers string[]
local defaults = {
    root_markers = { ".git" },
}

---@param opts? Opts
function M.setup(opts)
    opts = vim.tbl_deep_extend("force", defaults, opts or {})
    utils.init_pshada()
    cmd.setup(opts)
end

return M
