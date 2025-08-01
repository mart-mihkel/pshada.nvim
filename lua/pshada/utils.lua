local M = {}

local pshada_dir = vim.fn.stdpath("data") .. "/pshada/"

---@param root_markers string[]
---@return boolean
function M.cwd_is_project(root_markers)
    return vim.iter(root_markers):any(vim.uv.fs_stat)
end

function M.init_pshada()
    vim.uv.fs_mkdir(pshada_dir, tonumber("755", 8))
end

--- @return string
function M.pshada_file()
    local cwd = vim.fn.getcwd()
    local fname = vim.fs.basename(cwd) .. ".shada"
    return pshada_dir .. fname
end

---@param opts Opts
function M.read_pshada(opts)
    if not M.cwd_is_project(opts.root_markers) then
        return
    end

    local shadaf = M.pshada_file()
    if vim.uv.fs_stat(shadaf) then
        vim.cmd("rshada! " .. shadaf)
    end
end

---@param opts Opts
function M.write_pshada(opts)
    if not M.cwd_is_project(opts.root_markers) then
        return
    end

    vim.cmd("wshada! " .. M.pshada_file())
end

return M
