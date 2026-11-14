local ok, mypaths = pcall(require, "local-paths")
if not ok then
    mypaths = {}
    vim.notify("local-paths不存在，代码格式化部分配置未加载", vim.log.levels.WARN)
end

local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        -- css = { "prettier" },
        -- html = { "prettier" },
    },

    -- format_on_save = {
    --   -- These options will be passed to conform.format()
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- },
}

local clang_format_path = mypaths.clangFormat
if not clang_format_path then
    return options
end

options.formatters = {
    clang_format = {
        command =  clang_format_path,
        args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never, ColumnLimit: 0}" },
    },

}

return options
