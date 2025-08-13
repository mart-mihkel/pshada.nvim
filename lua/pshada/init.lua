local M = {}

local grp = vim.api.nvim_create_augroup("pshada-group", { clear = true })
local pshada_dir = vim.fn.stdpath("data") .. "/pshada/"

--- @class Opts
--- @field root_markers string[]
local defaults = {
    root_markers = { ".git" },
}

--- @return string
local function pshada_file()
    return pshada_dir .. vim.fs.basename(vim.fn.getcwd()) .. ".shada"
end

---@param root_markers string[]
---@return boolean
local function cwd_is_project(root_markers)
    return vim.iter(root_markers):any(vim.uv.fs_stat)
end

---@param opts? Opts
function M.setup(opts)
    opts = vim.tbl_deep_extend("force", defaults, opts or {})

    vim.uv.fs_mkdir(pshada_dir, tonumber("755", 8))

    vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
        group = grp,
        desc = "Read per-project shada",
        callback = function()
            if not cwd_is_project(opts.root_markers) then
                return
            end

            local shadaf = pshada_file()
            if vim.uv.fs_stat(shadaf) then
                vim.cmd("rshada! " .. shadaf)
            end
        end,
    })

    vim.api.nvim_create_autocmd({ "VimLeavePre", "DirChangedPre" }, {
        group = grp,
        desc = "Write per-project shada",
        callback = function()
            if not cwd_is_project(opts.root_markers) then
                return
            end

            vim.cmd("wshada! " .. pshada_file())
        end,
    })
end

return M
