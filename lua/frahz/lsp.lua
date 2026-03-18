vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if not client then
            return
        end

        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })

        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
        vim.keymap.set("n", "gD", vim.lsp.buf.definition)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
        vim.keymap.set("n", "gr", vim.lsp.buf.references)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
        vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
        vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format { async = true }
        end)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
    end
})


vim.diagnostic.config({
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.WARN] = "●",
            [vim.diagnostic.severity.INFO] = "●",
            [vim.diagnostic.severity.HINT] = "●",
        },
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        border = "single",
        source = true,
        header = "",
        prefix = "",
    },
})

vim.lsp.config("jsonls", {
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        }
    },
})

vim.lsp.config("yamlls", {
    settings = {
        yaml = {
            validate = true,
            completion = true,
            suggest = {
                parentSkeletonSelectedFirst = true,
            },
            schemas = require("schemastore").yaml.schemas(),
        },
        redhat = {
            telemetry = { enabled = false },
        },
    },
})

vim.lsp.enable({
    "bashls",
    "clangd",
    "cssls",
    "eslint",
    "gopls",
    "html",
    -- "htmx",
    "jsonls",
    "lua_ls",
    "marksman",
    "nil_ls",
    "pyright",
    "rust_analyzer",
    "svelte",
    "tailwindcss",
    "tinymist",
    "ts_ls",
    "yamlls"
})
