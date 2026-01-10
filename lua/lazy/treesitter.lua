return {
    {
        "nvim-treesitter",
        lazy = false,
        after = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { "*" },
                callback = function(args)
                    local ft = args.match or vim.bo[args.buf].filetype
                    local language = vim.treesitter.language.get_lang(ft) or ft

                    if vim.treesitter.language.add(language) then
                        vim.treesitter.start(args.buf, language)
                        vim.bo[args.buf].syntax = "ON"
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end
    },
    { "nvim-ts-context-commentstring" },
    { "rainbow-delimiters.nvim", },
}
