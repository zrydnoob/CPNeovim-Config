# 竞赛向 Neovim 配置 / Competitive Programming Neovim Config

**中文** | [English](#english)

---

## 简介 / Introduction

**中文**

此配置是我个人基于 [NvChad](https://github.com/NvChad/NvChad) 打造的、面向**算法竞赛**场景的 Neovim 编辑器配置。NvChad 的默认快捷键可参考 [NvChad Mappings 文档](https://nvchad.com/docs/config/mappings)（`<leader>` 默认为空格）。调试功能基于 [nvim-dap](https://github.com/mfussenegger/nvim-dap) 构建。

> ⚠️ **使用前警告**
>
> 本仓库主要用作**个人备份**。这份配置**并非 clone 后即可直接使用**：其中包含部分专属于我个人电脑的路径配置，且快捷键分布较为分散。如需使用，请自行补全缺失文件，并阅读源码查找快捷键。具体说明见下方 [使用说明](#使用说明--usage)。

**English**

This is my personal Neovim configuration built on top of [NvChad](https://github.com/NvChad/NvChad), tailored for **competitive programming**. NvChad's default keymaps are documented in the [NvChad Mappings page](https://nvchad.com/docs/config/mappings) (`<leader>` is `Space` by default). Debugging is powered by [nvim-dap](https://github.com/mfussenegger/nvim-dap).

> ⚠️ **Warning**
>
> This repo is primarily a **personal backup**. It is **not** ready to use after a simple `git clone`: some paths are hard-coded for my machine, and keymaps are scattered across files. If you intend to use it, complete the missing files yourself and read the source to discover keymaps. See [Usage](#english-usage) below.

---

## 功能特性 / Features

**中文**

- **全局一键复制代码**、代码格式化
- **UI 美化**：通知系统、透明背景主题
- **插件下载源镜像加速**
- **语言支持**：C++ 与 Python
- **调试与补全**：调试支持、UI、代码补全、实时语法检查、方法签名提示、一键编译/运行
- 其余 [NvChad](https://github.com/NvChad/NvChad) 原生功能

**English**

- **One-key copy entire buffer**, code formatting
- **UI polish**: notifications, transparent background theme
- **Mirror acceleration** for plugin downloads
- **Languages**: C++ and Python
- **Debug & completion**: debugging, UI, completion, real-time linting, signature help, one-key compile/run
- Everything else that ships with [NvChad](https://github.com/NvChad/NvChad)

---

## 使用说明 / Usage

**中文**

如需实际使用，请新建 `lua/local-paths.lua` 并填入以下配置：

```lua
-- 此文件已被 gitignore，不会上传
-- 仅保存本机独有的路径与配置

local M = {}

M.clangFormat = vim.fn.expand("此处填写 clang-format 的路径")
M.codelldb = vim.fn.expand("此处填写 codelldb 的路径")
M.miDebuggerPath = vim.fn.expand("此处填写 gdb 的路径")

return M
```

**English**

To actually use this config, create `lua/local-paths.lua` with the following:

```lua
-- This file is gitignored and will not be uploaded
-- Only machine-specific paths and settings live here

local M = {}

M.clangFormat = vim.fn.expand("PATH_TO_CLANG_FORMAT")
M.codelldb = vim.fn.expand("PATH_TO_CODELLDB")
M.miDebuggerPath = vim.fn.expand("PATH_TO_GDB")

return M
```

---

## 部分快捷键 / Keymaps

`<leader>` = `Space`。以下仅列出本配置独有的快捷键；其余请参考 [NvChad Mappings](https://nvchad.com/docs/config/mappings)。

### 编译、复制与格式化 / Compile, Copy & Format

| 快捷键 | 功能 |
| :--- | :--- |
| `<leader>rr` | 快速编译运行（C++ / Python） |
| `<leader>rc` | 复制全部代码，便于 OJ 提交 |
| `<leader>fm` | 格式化代码 |

### 调试 / Debugging

基于 [nvim-dap](https://github.com/mfussenegger/nvim-dap)。

| 快捷键 | 功能 |
| :--- | :--- |
| `F5` | 一键编译并开始调试 |
| `<leader>db` | 在当前行设置断点 |
| `<leader>dB` | 在当前行设置条件断点 |
| `<leader>dbl` | 在当前行设置日志断点 |
| `F6` | 单步跳过（Step Over） |
| `F7` | 单步进入（Step Into） |
| `F8` | 单步跳出（Step Out） |
| `F9` | 放行程序（Continue） |
| `<leader>dt` | 终止调试会话 |
| `<leader>du` | 切换调试 UI |
| `K` | 调试模式下显示光标处变量信息 |

### 终端与编辑辅助 / Terminal & Editing

| 快捷键 | 功能 |
| :--- | :--- |
| `K` | 普通模式下触发 `vim.lsp.buf.hover()` |
| `F2` | 切换底部终端 |
| `F3` | 切换悬浮终端 |
| `Ctrl+l` | 清除代码片段的 Tab 跳转标记，防止编辑时 Tab 乱跳 |

其余 NvChad 快捷键请直接查阅官方文档：[https://nvchad.com/docs/config/mappings](https://nvchad.com/docs/config/mappings)

---

### English Keymaps

`<leader>` = `Space`. Only **config-specific** keymaps are listed below; for the rest, see [NvChad Mappings](https://nvchad.com/docs/config/mappings).

| Key | Action |
| :--- | :--- |
| `<leader>rr` | Compile & run (C++ / Python) |
| `<leader>rc` | Copy entire buffer (for OJ submission) |
| `<leader>fm` | Format code |
| `F5` | Compile & start debugging |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Toggle conditional breakpoint |
| `<leader>dbl` | Toggle log point |
| `F6` | Step over |
| `F7` | Step into |
| `F8` | Step out |
| `F9` | Continue |
| `<leader>dt` | Terminate debug session |
| `<leader>du` | Toggle debug UI |
| `K` | Debug: inspect variable; Normal: `vim.lsp.buf.hover()` |
| `F2` | Toggle bottom terminal |
| `F3` | Toggle floating terminal |
| `Ctrl+l` | Clear snippet Tab-jump marks to avoid stray Tab jumps |

For all other NvChad keymaps: [https://nvchad.com/docs/config/mappings](https://nvchad.com/docs/config/mappings)

## 许可证 / License

**中文**

本仓库中由我原创的配置代码（快捷键、插件参数、本地路径模板等）采用 [MIT License](LICENSE) 发布。

本配置依赖以下项目，它们各自遵循其原始许可证：

- [NvChad](https://github.com/NvChad/NvChad)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim)
- 其余插件见 `lazy-lock.json` 及各插件仓库

本仓库不包含上述项目的源码，仅通过插件管理器引用。

**English**

The original configuration code in this repository (keymaps, plugin options, the local-path template, etc.) is released under the [MIT License](LICENSE).

This configuration depends on the following projects, each governed by its own original license:

- [NvChad](https://github.com/NvChad/NvChad)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim)
- For other plugins, see `lazy-lock.json` and the respective plugin repositories.

This repository does not include the source code of the projects listed above; they are referenced solely through the plugin manager.
