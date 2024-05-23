return {
    {"williamboman/mason.nvim"
    config = function()
        require("mason").setup()
    end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {"lua-ls", "tsserver"}
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.tsserver.setup({})

            vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, {})
            vim.keymap.set('n', '<C-d>', vim.lsp.buf.definition, {})
            vim.keymap.set('n', '<C-ca>', vim.lsp.buf.code_action, {})
        end
    }
}