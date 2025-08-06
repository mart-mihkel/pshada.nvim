local utils = require("pshada.utils")

local M = {}

local grp = vim.api.nvim_create_augroup("pshada-group", { clear = true })

---@param opts Opts
function M.setup(opts)
    vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
        group = grp,
        desc = "Read per-project shada",
        callback = function()
            utils.read_pshada(opts)
        end,
    })

    vim.api.nvim_create_autocmd({ "VimLeavePre", "DirChangedPre" }, {
        group = grp,
        desc = "Write per-project shada",
        callback = function()
            utils.write_pshada(opts)
        end,
    })
end

return M
