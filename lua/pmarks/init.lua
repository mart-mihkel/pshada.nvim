local M = {}

local defaults = {
    plugin_dir = vim.fn.stdpath("data") .. "/pmarks",
}

local function set_pmark()
    local buf = vim.api.nvim_get_current_buf()
    local cur = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_buf_set_mark(buf, "A", cur[1], cur[2], {})
end

---@param opts table|nil
function M.setup(opts)
    opts = opts or defaults

    vim.keymap.set({ "n", "v" }, "pm", set_pmark)
end

return M
