vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local initial_buf = vim.api.nvim_get_current_buf()

    vim.schedule(function()
      local ok, harpoon = pcall(require, "harpoon")
      if ok then
        local list = harpoon:list()

        -- Load all harpooned files as buffers
        for _, item in ipairs(list.items) do
          local path = vim.fn.fnamemodify(item.value, ":p")
          if vim.fn.filereadable(path) == 1 then
            local bufnr = vim.fn.bufadd(path)
            vim.fn.bufload(bufnr)
            vim.bo[bufnr].buflisted = true
          end
        end

        -- Open slot 1
        local item = list:get(1)
        if item then
          list:select(1)
        end
      end

      local name = vim.api.nvim_buf_get_name(initial_buf)
      local lines = vim.api.nvim_buf_get_lines(initial_buf, 0, -1, false)
      if vim.api.nvim_buf_is_valid(initial_buf) and name == "" and #lines == 1 and lines[1] == "" then
        vim.api.nvim_buf_delete(initial_buf, { force = true })
      end
    end)
  end,
})
