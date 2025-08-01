local M = {}

--- @class PshadaOptions
--- @field root_markers string[]
local defaults = {
    root_markers = { ".git" },
}

---@param opts? PshadaOptions
function M.setup(opts)
    opts = opts or defaults

    if vim.iter(opts.root_markers):any(vim.uv.fs_stat) then
        return
    end

    for i = string.byte("A"), string.byte("Z") do
        local c = string.char(i)
        vim.keymap.set({ "n", "v" }, "m" .. c, function()
            local buf = vim.api.nvim_get_current_buf()
            local cur = vim.api.nvim_win_get_cursor(0)
            vim.api.nvim_buf_set_mark(buf, c, cur[1], cur[2], {})
        end)
    end

    local cwd = vim.fn.getcwd()
    local shada = vim.fs.basename(cwd) .. ".shada"
    local pshada = vim.fn.stdpath("data") .. "/pmarks/" .. shada

    if vim.uv.fs_stat(pshada) then
        vim.cmd("rsh! " .. pshada)
    end

    vim.api.nvim_create_autocmd("VimLeavePre", {
        group = vim.api.nvim_create_augroup("pshada", { clear = true }),
        callback = function()
            vim.cmd("wsh! " .. pshada)
        end,
    })
end

return M
