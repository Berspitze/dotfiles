return {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "saghen/blink.cmp",
        "mfussenegger/nvim-dap",
    },

    opts = function()
        local metals = require("metals")
        local config = metals.bare_config()

        config.capabilities =
            require("blink.cmp").get_lsp_capabilities()

        config.init_options.statusBarProvider = "on"

        config.settings = {
            showImplicitArguments = true,
            showImplicitConversionsAndClasses = true,
            showInferredType = true,
            superMethodLensesEnabled = true,
            defaultBspToBuildTool = true,
            excludedPackages = {
                "akka.actor.typed.javadsl",
                "org.apache.pekko.actor.typed.javadsl",
                "com.github.swagger.akka.javadsl",
            },
        }

        config.on_attach = function(client, bufnr)
            vim.notify(
                "Metals attached: " .. client.name,
                vim.log.levels.INFO
            )

            local opts = { buffer = bufnr, silent = true }

            vim.keymap.set("n", "gd",
                vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gr",
                vim.lsp.buf.references, opts)
            vim.keymap.set("n", "K",
                vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>rn",
                vim.lsp.buf.rename, opts)

            require("metals").setup_dap()
        end

        return config
    end,

    config = function(_, config)
        local group = vim.api.nvim_create_augroup(
            "nvim-metals", { clear = true }
        )

        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            pattern = { "scala", "sbt", "java" },
            callback = function()
                require("metals").initialize_or_attach(config)
            end,
        })
    end,
}

