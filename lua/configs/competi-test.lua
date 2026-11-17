local ok, mypaths = pcall(require, "local-paths")
if not ok then
    mypaths = {}
    vim.notify("local-paths加载失败:"..tostring(mypaths), vim.log.levels.WARN)
end

local template_file = mypaths.code_template

require('competitest').setup({
    runner_ui = {
        interface = "popup",
    },
    view_output_diff = true,
    open_when_compilation_fails = true,

    -- 单独抓取的题目：在当前文件夹下，按 平台(JUDGE)/题目名(PROBLEM) 分类
    received_problems_path = "$(CWD)/$(JUDGE)/$(PROBLEM)/$(PROBLEM).$(FEXT)",
    -- 整场比赛的根目录：直接在当前文件夹下，以比赛ID(CONTEST)建文件夹
    received_contests_directory = "$(CWD)/$(CONTEST)",
    -- 比赛内每道题的路径：在比赛文件夹下，为每道题建独立子文件夹
    received_contests_problems_path = "$(PROBLEM)/$(PROBLEM).$(FEXT)",

    -- 为测试用例单独创建新的文件夹
    testcases_directory = "testcases",
    
    -- 代码模板
    template_file = template_file,
    evaluate_template_modifiers = true,
})

-- 相关按键绑定
local map = vim.keymap.set

map("n", "<leader>tr", ":CompetiTest run<CR>", { desc = "运行所有测试" })
