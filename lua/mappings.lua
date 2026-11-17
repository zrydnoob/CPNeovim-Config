require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Cod Runner
map('n', '<leader>rr', function()
  local filename = vim.fn.expand('%:p')
  local output   = vim.fn.expand('%:p:r')
  local ext      = vim.fn.expand('%:e')

  local cmd
  if ext == 'py' then
    cmd = string.format('uv run python "%s"', filename)
  else
    cmd = string.format(
      'g++ -std=c++17 -O2 -Wall "%s" -o "%s.exe" && "%s.exe"',
      filename, output, output)
  end

  vim.cmd('split | terminal cmd /c ' .. cmd)
end, { noremap = true, silent = true, desc = "Compile & run current file" })

-- 一键拷贝当前文件全部内容到系统剪贴板
map('n', '<leader>rc', function()
  vim.cmd(':%y+')
end, { noremap = true, silent = true, desc = "Copy entire file to clipboard" })

-- 终端相关
-- 底部终端切换
map({ "n", "t" }, "<F2>", function()
  require("nvchad.term").toggle {
    pos = "sp",
    id = "bottom_ps",
    size = 0.3,
  }
end, { desc = "Toggle bottom PowerShell terminal" })

-- 悬浮终端
map({ "n", "t" }, "<F3>", function()
  local term = require("nvchad.term")

  local cols = vim.o.columns
  local lines = vim.o.lines

  local w_ratio = 0.6
  local h_ratio = 0.7

  local win_w = math.floor(cols * w_ratio)
  local win_h = math.floor(lines * h_ratio)

  local col = math.floor((cols - win_w) / 2)
  local row = math.floor((lines - win_h) / 2)

  term.toggle {
    pos = "float",
    id = "float_ps",
    float_opts = {
      border = "rounded",
      width = win_w,
      height = win_h,
      row = row,
      col = col
    },
  }
end, { desc = "Toggle float PowerShell terminal" })


map({"i", "s"}, "<C-l>", function()
  local ls = require("luasnip")
  if ls.in_snippet() then
    ls.unlink_current()
  end
end, {silent = true, desc = "Luasnip cancel snippet session"})
