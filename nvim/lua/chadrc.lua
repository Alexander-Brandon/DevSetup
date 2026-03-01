-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "doomchad",
  hl_add = {

    ["GitSignsCurrentLineBlame"] = { fg = "teal", bold = true }
  }
}

-- ToggleTerm Statusline
M.ui = {
  statusline = {
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "terminals", "cwd", "cursor" },
    modules = {
      terminals = function()
        -- Only show when toggleterm is loaded
        local ok, _ = pcall(require, "toggleterm.terminal")
        if not ok or not _G.toggleterm_instances then return "" end

        local parts = {}
        for i, term in ipairs(_G.toggleterm_instances) do
          local is_current = (i == _G.toggleterm_current_idx())
          local name = term.display_name or ("Term " .. i)
          if is_current then
            table.insert(parts, "[" .. name .. "]")
          else
            table.insert(parts, name)
          end
        end

        if #parts == 0 then return "" end
        return " " .. table.concat(parts, " | ") .. " "
      end,
    },
  },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }
--

return M
