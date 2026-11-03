return {
    -- lazy.nvim
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = require "configs.noice-ui",
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
    {
        "rcarriga/nvim-notify",
        opts = {
            background_colour = function()
                local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
                return string.format("#%06x", hl.bg or 0x000000)
            end,
        }
    }
}
