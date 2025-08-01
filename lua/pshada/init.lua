local M = {}

--- @class PshadaOptions
--- @field root_markers string[]
local defaults = {
    root_markers = { ".git" },
}

---@param opts? PshadaOptions
function M.setup(opts)
    opts = opts or defaults

    if not vim.iter(opts.root_markers):all(vim.uv.fs_stat) then
        return
    end

    local cwd = vim.fn.getcwd()
    local dir = vim.fn.stdpath("data") .. "/pshada/"
    local shada = dir .. vim.fs.basename(cwd) .. ".shada"

    vim.uv.fs_mkdir(dir, tonumber("755", 8))
    if vim.uv.fs_stat(shada) then
        vim.cmd("rsh! " .. shada)
    end

    vim.api.nvim_create_autocmd("VimLeavePre", {
        group = vim.api.nvim_create_augroup("pshada", { clear = true }),
        callback = function()
            vim.cmd("wsh! " .. shada)
        end,
    })
end

return M
