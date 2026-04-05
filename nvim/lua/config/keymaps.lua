local map = vim.keymap.set

--- Diagnostic Commands are <leader>e*
map("n", "<leader>eD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "<leader>ed", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>ef", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
map("n", "<leader>eh", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>ej", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
map("n", "<leader>ek", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Previous diagnostic" })

--- Window Navigation are <C-*>
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

--- Fuzzy Find Commands are <leader>l*
map("n", "<leader>lf", "<cmd>FzfLua files<cr>", { desc = "Find files" })
map("n", "<leader>lg", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>lk", "<cmd>FzfLua keymaps<cr>", { desc = "Keymaps" })
map("n", "<leader>lr", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>ls", "<cmd>FzfLua grep_cword<cr>", { desc = "Search word under cursor" })
map("n", "<leader>lb", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })

--- Harpoon Commands are <leader>h*
local harpoon = require("harpoon")

harpoon:setup()

map("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "Harpoon Add" })
map("n", "<leader>he", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Toggle Menu" })
map("n", "<leader>hh", function()
  harpoon:list():prev()
end, { desc = "Harpoon: prev" })
map("n", "<leader>hl", function()
  harpoon:list():next()
end, { desc = "Harpoon: next" })
local function harpoon_desc(idx)
  return function()
    local item = harpoon:list():get(idx)
    return item and ("Harpoon: " .. vim.fn.fnamemodify(item.value, ":t")) or ("Harpoon slot " .. idx)
  end
end

local wk = require("which-key")

wk.add({
  { "<leader>b", group = "Buffer" },
  { "<leader>e", group = "LSP", icon = "⚙" },
  { "<leader>f", group = "Format" },
  { "<leader>g", group = "Git" },
  { "<leader>h", group = "Harpoon", icon = "⚓" },
  { "<leader>l", group = "Finder" },
})

local harpoon_entries = {}
for i = 1, 9 do
  table.insert(harpoon_entries, {
    "<leader>h" .. i,
    function()
      harpoon:list():select(i)
    end,
    desc = harpoon_desc(i),
  })
end
wk.add(harpoon_entries)

--- Git Commands are <leader>g*
map("n", "<leader>gg", function()
  vim.fn.jobstart({ "wezterm", "cli", "split-pane", "--right", "--", "lazygit" }, { detach = true })
end, { desc = "Open LazyGit" })

--- Buffer Commands are <leader>b*
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buffer" })

--- Conform Commands are <leader>f*
map({ "n", "x" }, "<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

