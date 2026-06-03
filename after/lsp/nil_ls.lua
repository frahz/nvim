---@type vim.lsp.Config
return {
    settings = {
        ['nil'] = {
            formatting = {
                command = { "nixfmt" },
            },
            nix = {
                maxMemoryMB = 8196,
                flake = {
                    autoArchive = false,
                    autoEvalInputs = false,
                },
            }
        }
    }
}
