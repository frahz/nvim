---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "LZN" },
                disable = { "missing-fields" },
            },
            hint = {
                enable = true,
                arrayIndex = "Disable",
            },
            workspace = {
                library = {},
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
