local ok, mypaths = pcall(require, "local-paths")
if not ok then
    mypaths = {}
    vim.notify("local-paths不存在，代码格式化部分配置未加载", vim.log.levels.WARN)
end


local dap = require("dap")

-- 自动编译并返回可执行文件路径
local function build_and_get_exe()
    local file = vim.fn.expand("%:p")
    local dir = vim.fn.fnamemodify(file, ":h")
    local name = vim.fn.fnamemodify(file, ":t:r")
    local exe = dir .. "/" .. name
    local cmd = "g++ -g -o " .. exe .. " " .. file

    vim.notify("Compiling: " .. cmd, vim.log.levels.INFO)
    local output = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
        vim.notify("Compilation failed:\n" .. output, vim.log.levels.ERROR)
        return nil
    end
    vim.notify("Compilation successful", vim.log.levels.INFO)

    return exe
end

require("dap-python").setup("uv")

dap.defaults.auto_continue_if_many_stopped = false

-- 关闭异常断点
dap.listeners.before.launch.dap_exception_fix = function()
    dap.set_exception_breakpoints({})
end

local codelldb_path = mypaths.codelldb
local gdb_path = mypaths.mi_debugger

if not codelldb_path or not gdb_path then
    return
end

dap.adapters.codelldb = {
    type = "executable",
    command = codelldb_path,
    detached = false
}

dap.configurations.cpp = {
    {
        name = "Launch file (gdb)",
        type = "codelldb",
        request = "launch",
        program = function()
            return build_and_get_exe()
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
        externalConsole = false,
        MIMode = "gdb",
        miDebuggerPath = gdb_path,
        setupCommands = {
            { text = "-enable-pretty-printing", description = "STL pretty printing", ignoreFailures = false },
            -- 若 info pretty-printer 里没有 libstdc++-v6，再补这一条（路径按你实际）
            -- { text = "python import sys; sys.path.insert(0, 'D:/mingw64/share/gcc-13/python'); from libstdcxx.v6.printers import register_libstdcxx_printers; register_libstdcxx_printers(None)", ignoreFailures = false },
            { text = "set print elements 50", description = "大容器只显示前50个" },
            { text = "set print pretty on", description = "结构化缩进" },
        },
    },
}

dap.configurations.c = dap.configurations.cpp
