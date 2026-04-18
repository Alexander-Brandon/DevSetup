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

--- Window Navigation & Line Moves are <C-*>
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

map("n", "<C-PageDown>", "<cmd>m +1<cr>", { desc = "Move Line Down" })
map("n", "<C-PageUp>", "<cmd>m -2<cr>", { desc = "Move Line Up" })

--- Fuzzy Find Commands are <leader>l*
map("n", "<leader>lf", "<cmd>FzfLua files<cr>", { desc = "Find files" })
map("n", "<leader>lg", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>lk", "<cmd>FzfLua keymaps<cr>", { desc = "Keymaps" })
map("n", "<leader>lr", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>ls", "<cmd>FzfLua grep_cword<cr>", { desc = "Search word under cursor" })
map("n", "<leader>lb", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
map("n", "<leader>lm", "<cmd>FzfLua marks<cr>", { desc = "Marks" })

--- Marks Commands are <leader>M*
local wk = require("which-key")

wk.add({
  { "<leader>b", group = "Buffer" },
  { "<leader>e", group = "LSP", icon = "⚙" },
  { "<leader>f", group = "Format" },
  { "<leader>g", group = "Git" },
  { "<leader>l", group = "Finder" },
  { "<leader>M", group = "Marks" },
  { "<leader>Ma", group = "Set mark" },
  { "<leader>Md", group = "Delete mark" },
})

local mark_entries = {}
for i = 0, 25 do
  local letter = string.char(65 + i)

  table.insert(mark_entries, {
    "<leader>Ma" .. letter,
    function()
      local existing = nil
      for _, m in ipairs(vim.fn.getmarklist()) do
        if m.mark == "'" .. letter then
          existing = vim.fn.fnamemodify(m.file, ":.")
          break
        end
      end
      if existing then
        local choice = vim.fn.confirm("Mark " .. letter .. " is set to " .. existing .. ". Overwrite?", "&Yes\n&No")
        if choice ~= 1 then
          return
        end
      end
      vim.cmd("mark " .. letter)
    end,
    desc = function()
      for _, m in ipairs(vim.fn.getmarklist()) do
        if m.mark == "'" .. letter then
          return "Set mark " .. letter .. " (" .. vim.fn.fnamemodify(m.file, ":t") .. ")"
        end
      end
      return "Set mark " .. letter
    end,
  })

  table.insert(mark_entries, {
    "<leader>M" .. letter,
    function()
      vim.cmd("normal! '" .. letter)
    end,
    desc = function()
      for _, m in ipairs(vim.fn.getmarklist()) do
        if m.mark == "'" .. letter then
          return "Mark " .. letter .. ": " .. vim.fn.fnamemodify(m.file, ":t")
        end
      end
      return "Mark " .. letter .. " (unset)"
    end,
  })

  table.insert(mark_entries, {
    "<leader>Md" .. letter,
    function()
      vim.cmd("delmarks " .. letter)
      vim.notify("Mark " .. letter .. " deleted")
    end,
    desc = "Delete mark " .. letter,
  })
end

wk.add(mark_entries)

--- Git Commands are <leader>g*
map("n", "<leader>gg", function()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded",
  })
  vim.fn.termopen("lazygit", {
    on_exit = function()
      vim.api.nvim_win_close(win, true)
    end,
  })
  vim.cmd("startinsert")
end, { desc = "Open LazyGit" })

--- Buffer Commands are <leader>b*
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close buffer" })

--- Conform Commands are <leader>f*
map({ "n", "x" }, "<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })
