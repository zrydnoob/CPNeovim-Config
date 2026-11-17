# 竞赛向 Neovim 配置 / Competitive Programming Neovim Config

**中文** | [English](#english)

---

## 简介 / Introduction

**中文**

此配置是我个人基于 [NvChad](https://github.com/NvChad/NvChad) 打造的、面向**算法竞赛**场景的 Neovim 编辑器配置。NvChad 的默认快捷键可参考 [NvChad Mappings 文档](https://nvchad.com/docs/config/mappings)（`<leader>` 默认为空格）。调试功能基于 [nvim-dap](https://github.com/mfussenegger/nvim-dap) 构建；题目抓取与本地评测基于 [CompetiTest.nvim](https://github.com/xeluxee/competitest.nvim) 与 [Competitive Companion](https://github.com/jmerle/competitive-companion) 构建。

> ⚠️ **使用前警告**
>
> 本仓库主要用作**个人备份**。这份配置**并非 clone 后即可直接使用**：其中包含部分专属于我个人电脑的路径配置，且快捷键分布较为分散。如需使用，请自行补全缺失文件，并阅读源码查找快捷键。具体说明见下方 [使用说明](#使用说明--usage)。

**English**

This is my personal Neovim configuration built on top of [NvChad](https://github.com/NvChad/NvChad), tailored for **competitive programming**. NvChad's default keymaps are documented in the [NvChad Mappings page](https://nvchad.com/docs/config/mappings) (`<leader>` is `Space` by default). Debugging is powered by [nvim-dap](https://github.com/mfussenegger/nvim-dap); problem scraping and local judging are powered by [CompetiTest.nvim](https://github.com/xeluxee/competitest.nvim) and [Competitive Companion](https://github.com/jmerle/competitive-companion).

> ⚠️ **Warning**
>
> This repo is primarily a **personal backup**. It is **not** ready to use after a simple `git clone`: some paths are hard-coded for my machine, and keymaps are scattered across files. If you intend to use it, complete the missing files yourself and read the source to discover keymaps. See [Usage](#english-usage) below.

---

## 功能特性 / Features

**中文**

- **全局一键复制代码**、代码格式化
- **浏览器一键抓题**：配合 [Competitive Companion](https://github.com/jmerle/competitive-companion) 浏览器扩展，可在 OJ 页面一键抓取题目与测试用例到本地
- **本地测试用例管理与评测**：基于 [CompetiTest.nvim](https://github.com/xeluxee/competitest.nvim)，支持运行全部用例、查看输出差异、编译失败自动弹窗
- **代码模板自动填充**：抓题时自动套用本地代码模板，并注入题目名、比赛、平台、URL、时间/内存限制等元信息
- **UI 美化**：通知系统、透明背景主题
- **插件下载源镜像加速**
- **语言支持**：C++ 与 Python
- **调试与补全**：调试支持、UI、代码补全、实时语法检查、方法签名提示、一键编译/运行
- 其余 [NvChad](https://github.com/NvChad/NvChad) 原生功能

**English**

- **One-key copy entire buffer**, code formatting
- **One-click problem scraping**: with the [Competitive Companion](https://github.com/jmerle/competitive-companion) browser extension, grab problems and test cases from OJ pages straight into the editor
- **Local test case management & judging**: powered by [CompetiTest.nvim](https://github.com/xeluxee/competitest.nvim); run all test cases, view output diffs, auto-popup on compilation failure
- **Auto-filled code template**: when receiving a problem, the local template is applied and enriched with problem name, contest, judge, URL, time/memory limits, etc.
- **UI polish**: notifications, transparent background theme
- **Mirror acceleration** for plugin downloads
- **Languages**: C++ and Python
- **Debug & completion**: debugging, UI, completion, real-time linting, signature help, one-key compile/run
- Everything else that ships with [NvChad](https://github.com/NvChad/NvChad)

---

## 使用说明 / Usage

**中文**

### 1. 补全本机路径文件

如需实际使用，请新建 `lua/local-paths.lua` 并填入以下配置（该文件已被 `.gitignore` 排除，不会上传）：

```lua
-- 此文件已被 gitignore，不会上传
-- 仅保存本机独有的路径与配置

local M = {}

M.clang_format   = vim.fn.expand("此处填写 clang-format 的路径")
M.codelldb       = vim.fn.expand("此处填写 codelldb 的路径")
M.mi_debugger    = vim.fn.expand("此处填写 gdb 的路径")

-- 代码模板（CompetiTest 抓题时自动套用）
-- 字段名必须是 snake_case 的 code_template，
-- 与主配置里 require 后的引用保持一致
M.code_template = {
    cpp = vim.fn.expand("此处填写你的 C++ 代码模板路径"),
}

return M
```

> 若 `M.code_template` 缺失或为空，抓题功能仍可正常工作，只是生成的文件内容为空（不会套用模板）。

### 2. 安装浏览器扩展

抓题依赖浏览器扩展 **Competitive Companion**（Chrome / Edge / Firefox 均可安装）。安装后无需额外配置，默认会向本地 `27121` 端口发送数据。

### 3. 抓题与测试的基本流程

1. 在 Neovim 中打开终端，`cd` 到你想存放本次题目的文件夹。
2. 执行 `:CompetiTest receive problem`（单题）或 `:CompetiTest receive contest`（整场比赛）进入接收状态。
3. 在浏览器打开目标 OJ 的题目页，点击 Competitive Companion 图标（或快捷键 `Ctrl+Shift+U`）。
4. 题目和测试用例会自动保存到当前文件夹下的 `平台/题目名/` 子目录，源文件按模板生成。
5. 在源文件中按 `<leader>tr` 运行全部测试用例。

### 4. 目录结构约定

```
<当前文件夹>/
├── Codeforces/            # $(JUDGE)
│   └── 1234A/             # $(PROBLEM)
│       ├── 1234A.cpp      # 按模板生成
│       └── testcases/     # 测试用例
│           ├── 1234A_input0.txt
│           └── 1234A_output0.txt
└── 1234/                  # 整场比赛（$(CONTEST)）
    ├── A/A.cpp
    └── B/B.cpp
```

**English**

### 1. Complete the local path file

To actually use this config, create `lua/local-paths.lua` with the following (this file is excluded by `.gitignore` and won't be uploaded):

```lua
-- This file is gitignored and will not be uploaded
-- Only machine-specific paths and settings live here

local M = {}

M.clang_format   = vim.fn.expand("PATH_TO_CLANG_FORMAT")
M.codelldb       = vim.fn.expand("PATH_TO_CODELLDB")
M.mi_debugger    = vim.fn.expand("PATH_TO_GDB")

-- Code template (auto-applied when receiving a problem)
-- The field name must be snake_case: code_template,
-- matching the reference in the main config after require
M.code_template = {
    cpp = vim.fn.expand("PATH_TO_YOUR_CPP_TEMPLATE"),
}

return M
```

> If `M.code_template` is missing or empty, receiving still works — generated files are just blank (no template applied).

### 2. Install the browser extension

Scraping relies on the **Competitive Companion** browser extension (available for Chrome / Edge / Firefox). No extra setup needed — it sends data to `localhost:27121` by default.

### 3. Basic workflow

1. In Neovim, `cd` into the folder where you want this problem's files to live.
2. Run `:CompetiTest receive problem` (single problem) or `:CompetiTest receive contest` (whole contest) to enter receiving mode.
3. Open the OJ problem page in your browser and click the Competitive Companion icon (or press `Ctrl+Shift+U`).
4. The problem and test cases are saved under `judge/problem/` in the current folder; the source file is generated from your template.
5. In the source file, press `<leader>tr` to run all test cases.

### 4. Directory layout

```
<cwd>/
├── Codeforces/            # $(JUDGE)
│   └── 1234A/             # $(PROBLEM)
│       ├── 1234A.cpp      # generated from template
│       └── testcases/
│           ├── 1234A_input0.txt
│           └── 1234A_output0.txt
└── 1234/                  # whole contest ($(CONTEST))
    ├── A/A.cpp
    └── B/B.cpp
```

---

## 部分快捷键 / Keymaps

`<leader>` = `Space`。以下仅列出本配置独有的快捷键；其余请参考 [NvChad Mappings](https://nvchad.com/docs/config/mappings)。

### 编译、复制与格式化 / Compile, Copy & Format

**中文**

| 快捷键 | 功能 |
| :--- | :--- |
| `<leader>rr` | 快速编译运行（C++ / Python） |
| `<leader>rc` | 复制全部代码，便于 OJ 提交 |
| `<leader>fm` | 格式化代码 |

**English**

| Key | Action |
| :--- | :--- |
| `<leader>rr` | Compile & run (C++ / Python) |
| `<leader>rc` | Copy entire buffer (for OJ submission) |
| `<leader>fm` | Format code |

### 题目抓取与本地测试 / Problem Scraping & Local Testing

基于 [CompetiTest.nvim](https://github.com/xeluxee/competitest.nvim) 与 Competitive Companion。

**中文**

| 快捷键 / 命令 | 功能 |
| :--- | :--- |
| `<leader>tr` | 运行全部测试用例（编译 + 逐一评测） |
| `:CompetiTest receive problem` | 进入接收模式，等待浏览器发送**单题**数据 |
| `:CompetiTest receive contest` | 进入接收模式，等待浏览器发送**整场比赛**数据 |
| `:CompetiTest receive testcases` | 仅接收测试用例，不生成源文件 |
| `:CompetiTest run` | 同 `<leader>tr`，编译并运行全部用例 |
| `:CompetiTest run_no_compile` | 跳过编译，直接运行已有可执行文件的测试 |
| `:CompetiTest add_testcase [n]` | 新增测试用例（可指定编号） |
| `:CompetiTest edit_testcase [n]` | 编辑指定编号的测试用例 |
| `:CompetiTest delete_testcase [n]` | 删除指定编号的测试用例 |

> 在测试结果弹窗内：`R` 重跑当前用例、`q` 关闭窗口。

**English**

| Key / Command | Action |
| :--- | :--- |
| `<leader>tr` | Run all test cases (compile + judge) |
| `:CompetiTest receive problem` | Enter receiving mode for a single problem |
| `:CompetiTest receive contest` | Enter receiving mode for a whole contest |
| `:CompetiTest receive testcases` | Receive test cases only (no source file) |
| `:CompetiTest run` | Same as `<leader>tr` |
| `:CompetiTest run_no_compile` | Run tests without recompiling |
| `:CompetiTest add_testcase [n]` | Add a test case (optional index) |
| `:CompetiTest edit_testcase [n]` | Edit a test case (optional index) |
| `:CompetiTest delete_testcase [n]` | Delete a test case (optional index) |

> Inside the result popup: `R` reruns the current test case, `q` closes the window.

### 调试 / Debugging

基于 [nvim-dap](https://github.com/mfussenegger/nvim-dap)。

**中文**

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

**English**

| Key | Action |
| :--- | :--- |
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
| `K` | Debug: inspect variable under cursor |

### 终端与编辑辅助 / Terminal & Editing

**中文**

| 快捷键 | 功能 |
| :--- | :--- |
| `K` | 普通模式下触发 `vim.lsp.buf.hover()` |
| `F2` | 切换底部终端 |
| `F3` | 切换悬浮终端 |
| `Ctrl+l` | 清除代码片段的 Tab 跳转标记，防止编辑时 Tab 乱跳 |

**English**

| Key | Action |
| :--- | :--- |
| `K` | Normal mode: `vim.lsp.buf.hover()` |
| `F2` | Toggle bottom terminal |
| `F3` | Toggle floating terminal |
| `Ctrl+l` | Clear snippet Tab-jump marks to avoid stray Tab jumps |

其余 NvChad 快捷键请直接查阅官方文档：For all other NvChad keymaps, see [https://nvchad.com/docs/config/mappings](https://nvchad.com/docs/config/mappings)

---

## 已知限制 / Known Limitations

**中文**

- 抓题依赖浏览器扩展 **Competitive Companion**，请确保它已安装且允许访问 `localhost:27121`。
- 对 **Virtual Judge (VJ)** 的支持间接依赖扩展对页面结构的解析；若原版扩展在 VJ 上失效，可尝试社区用户脚本（如 "Competitive Companion for Vjudge"）。
- `:CompetiTest receive status` 显示的是**数据接收状态**，不是 OJ 提交判决状态。本配置不包含自动提交功能。
- 代码模板路径、调试器路径、clang-format 路径均为**本机路径**，需要自行补全 `lua/local-paths.lua` 后才能生效。

**English**

- Scraping relies on the **Competitive Companion** browser extension; make sure it is installed and allowed to reach `localhost:27121`.
- **Virtual Judge (VJ)** support depends indirectly on the extension's page parser; if the official extension fails on VJ, try community userscripts such as "Competitive Companion for Vjudge".
- `:CompetiTest receive status` shows **data receiving state**, not OJ submission verdicts. This config does not include auto-submission.
- Template / debugger / clang-format paths are **machine-specific**; you must fill in `lua/local-paths.lua` first.

---

## 许可证 / License

**中文**

本仓库中由我原创的配置代码（快捷键、插件参数、本地路径模板等）采用 [MIT License](LICENSE) 发布。

本配置依赖以下项目，它们各自遵循其原始许可证：

- [NvChad](https://github.com/NvChad/NvChad)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [CompetiTest.nvim](https://github.com/xeluxee/competitest.nvim)
- [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim)
- 其余插件见 `lazy-lock.json` 及各插件仓库

本仓库不包含上述项目的源码，仅通过插件管理器引用。

**English**

The original configuration code in this repository (keymaps, plugin options, the local-path template, etc.) is released under the [MIT License](LICENSE).

This configuration depends on the following projects, each governed by its own original license:

- [NvChad](https://github.com/NvChad/NvChad)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- [CompetiTest.nvim](https://github.com/xeluxee/competitest.nvim)
- [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim)
- For other plugins, see `lazy-lock.json` and the respective plugin repositories.

This repository does not include the source code of the projects listed above; they are referenced solely through the plugin manager.
