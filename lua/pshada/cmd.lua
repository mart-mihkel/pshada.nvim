local utils = require("pshada.utils")

local M = {}

---@param opts Opts
function M.setup(opts)
    vim.api.nvim_create_autocmd({ "UIEnter", "DirChanged" }, {
        group = vim.api.nvim_create_augroup("pshada-read", {}),
        callback = function()
            utils.read_pshada(opts)
        end,
    })

    vim.api.nvim_create_autocmd({ "VimLeavePre", "DirChangedPre" }, {
        group = vim.api.nvim_create_augroup("pshada-write", {}),
        callback = function()
            utils.write_pshada(opts)
        end,
    })
end

return M
