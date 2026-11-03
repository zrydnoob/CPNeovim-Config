require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePre", {
  pattern = { "*.cpp", "*.cc", "*.c", "*.h", "*.hpp" },
  callback = function()
    require("conform").format({ async = false, lsp_fallback = true })
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    local luasnip = require("luasnip")
    if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
      and not luasnip.session.jump_active then
      luasnip.unlink_current()
    end
  end,
})
