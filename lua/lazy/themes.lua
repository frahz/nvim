return {
    {
        "catppuccin",
        lazy = false,
        priority = 1200,
        after = function()
            require("catppuccin").setup({
                flavour = "mocha",
                no_italic = true,
                lsp_styles = { inlay_hints = { background = false } },
                integrations = { blink_cmp = true },
            })
            vim.cmd.colorscheme("catppuccin-nvim")
        end
    },
}
