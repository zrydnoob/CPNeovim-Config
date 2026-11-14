require("nvchad.configs.lspconfig").defaults()

-- 关闭自动补全头文件
vim.lsp.config.clangd = {
    cmd = {
        'clangd',
        '--header-insertion=never'
    }
}

local servers = { "html", "cssls", "pyright", "clangd"}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
vim.keymap.set('i', '<C-k>', function()
  vim.lsp.buf.signature_help({
    focus = false,        -- 关键：禁止窗口获取焦点
    focusable = false,    -- 窗口本身不可被聚焦
    border = "rounded",   -- 圆角边框
    max_height = 20,      -- 最大高度，避免遮挡
    max_width = 100,       -- 最大宽度
  })
end, { desc = "LSP Signature Help (no focus)" })
