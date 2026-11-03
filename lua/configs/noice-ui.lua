local options = {
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
        signature = { enabled = false }
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
    -- 关键：关闭noice接管vim.ui.select，DAP线程/进程选择框回归原生nvim
    ui_select = false,
    views = {
        popupmenu = { backend = "nui" }
    },
    routes = {
        -- 过滤掉dap相关消息，不交给noice渲染
        { filter = { event = "msg_show", find = "dap" }, view = "notify", opts = { skip = true } },
        -- 删掉原来那条 stop=true 的popupmenu路由，它会干扰补全popupmenu
        -- { filter = { event = "popupmenu" }, view = "popupmenu", opts = { stop = true } }
    }
}

return options
