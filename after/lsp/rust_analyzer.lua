---@type vim.lsp.Config
return {
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            files = {
                excludeDirs = { ".direnv" },
            },
            procMacro = {
                enable = true
            },
        },
    },
}
