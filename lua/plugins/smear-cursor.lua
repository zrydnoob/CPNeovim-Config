return {
    "sphamba/smear-cursor.nvim",
    lazy = false,
    opts = {
        -- 物理参数：稍松弛 + 高阻尼 = 丝滑且有拖尾感
        stiffness = 0.7,               -- 比默认 0.8 稍松弛，移动更柔和
        trailing_stiffness = 0.45,     -- 拖尾更“松散”，拉出更明显的轨迹
        damping = 0.96,                -- 略高于默认，确保拉长后依然稳定不抖

        -- 插入模式：保持略微更紧致的手感，避免打字时拖尾干扰
        stiffness_insert_mode = 0.8,
        trailing_stiffness_insert_mode = 0.55,
        damping_insert_mode = 0.97,

        -- 动画停止阈值：调低一点，让光标更“精准”地落位
        distance_stop_animating = 0.3,

        -- 质感提升开关
        legacy_computing_symbols_support = true, -- 字体支持时，拖尾更细腻（Cascadia Code 等）
        cursor_color = "none",                   -- 让拖尾颜色匹配目标位置文字色，融入感更强
    },
}
