local dap = require("dap")
local dapui = require("dap-view")

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

-- 此处Windows有bug 会导致管道破裂，屏幕不刷新Nvim直接退出
-- dap.listeners.before.event_terminated.dapui_config = function()
--     vim.schedule(function()
--         dapui.close()
--     end
--     )
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--     vim.schedule(function()
--         dapui.close()
--     end
--     )
-- end

-- 自定义Debug图标
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "Comment", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "➜", texthl = "DiagnosticOk", linehl = "Visual", numhl = "" })

vim.keymap.set("n", "<F5>", dap.continue, { desc = "启动/继续调试" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "切换断点" })

vim.keymap.set("n", "<leader>dB", function()
    local cond = vim.fn.input("Breakpoint condition(gdb expr): ")
    if cond ~= "" then
        dap.set_breakpoint(cond)
    end
end, { desc = "DAP Conditional breakpoint" })

vim.keymap.set("n", "<leader>dbl", function()
      local logmsg = vim.fn.input("Log point message (use ${var}): ")
      if logmsg ~= "" then
        dap.set_breakpoint(nil, nil, logmsg)
      end
    end, { desc = "DAP Log point (no pause)" })

vim.keymap.set("n", "<F6>", dap.step_over, { desc = "单步跳过" })
vim.keymap.set("n", "<F7>", dap.step_into, { desc = "单步进入" })
vim.keymap.set("n", "<F8>", dap.step_out, { desc = "单步跳出" })
vim.keymap.set("n", "<F9>", dap.continue, { desc = "放行程序" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "切换调试 UI" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "终止调试会话" })

vim.keymap.set("n", "K", function()
    if dap.session() then
        dapui.hover()
    else
        vim.lsp.buf.hover()
    end
end, { desc = "Dap / LSP Hover" })
