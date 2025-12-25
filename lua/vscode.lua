--------------------------------------------------
-- VS Code 专用映射
--------------------------------------------------
local map = vim.keymap.set
local vscode = require("vscode")

map("n", "<leader>w", function()
    vscode.action("workbench.action.files.save")
end)

map("n", "<leader>q", function()
    vscode.action("workbench.action.closeActiveEditor")
end)

map("n", "<leader>ff", function()
    vscode.action("workbench.action.quickOpen")
end)

map("n", "<leader>fg", function()
    vscode.action("workbench.action.findInFiles")
end)

map("n", "<leader>e", function()
    vscode.action("workbench.view.explorer")
end)

map("n", "gd", function()
    vscode.action("editor.action.revealDefinition")
end)

map("n", "gr", function()
    vscode.action("editor.action.goToReferences")
end)

map("n", "K", function()
    vscode.action("editor.action.showHover")
end)
