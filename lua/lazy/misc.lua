local is_wsl = vim.uv.os_uname().sysname == 'Linux' and vim.uv.os_uname().release:lower():find 'microsoft'
return {
    {
        "guess-indent.nvim",
        after = function()
            require("guess-indent").setup({})
        end,
    },
    {
        "typst-preview.nvim",
        ft = "typst",
        after = function()
            require("typst-preview").setup({
                open_cmd = is_wsl and "wsl-open %s",
                dependencies_bin = {
                    ["tinymist"] = "tinymist",
                    ["websocat"] = "websocat"
                },
            })
        end,
    },
    {
        "tiny-inline-diagnostic.nvim",
        event = "DeferredUIEnter",
        after = function()
            require("tiny-inline-diagnostic").setup({
                preset = "classic",
            })
        end
    }
}
