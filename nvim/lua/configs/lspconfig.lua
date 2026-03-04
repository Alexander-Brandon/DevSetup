require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "rust_analyzer", "emmylua_ls", "vimls"}
vim.lsp.enable(servers)

-- Custom highlight colors for hover window
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2e", fg = "#cdd6f4" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#89b4fa" })

-- read :h vim.lsp.config for changing options of lsp servers
