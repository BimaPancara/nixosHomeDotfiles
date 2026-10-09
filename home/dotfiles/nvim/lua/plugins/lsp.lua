return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },

        config = function()
            local caps = require("cmp_nvim_lsp").default_capabilities()

            -- Diagnostics
            vim.diagnostic.config({
                virtual_text = true,
                severity_sort = true,

                float = {
                    style = "minimal",
                    border = "rounded",
                    source = "if_many",
                    header = "",
                    prefix = "",
                },

                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "✘",
                        [vim.diagnostic.severity.WARN] = "▲",
                        [vim.diagnostic.severity.HINT] = "⚑",
                        [vim.diagnostic.severity.INFO] = "»",
                    },
                },
            })

            -- LSP floating windows
            local orig = vim.lsp.util.open_floating_preview

            ---@diagnostic disable-next-line: duplicate-set-field
            vim.lsp.util.open_floating_preview = function(
                contents,
                syntax,
                opts,
                ...
            )
                opts = opts or {}
                opts.border = opts.border or "rounded"
                opts.max_width = opts.max_width or 80
                opts.max_height = opts.max_height or 24
                opts.wrap = opts.wrap ~= false

                return orig(contents, syntax, opts, ...)
            end

            -- Default project root
            vim.lsp.config("*", {
                root_markers = { ".git" },
            })

            -- LSP keybindings
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("my.lsp", {}),
                callback = function(args)
                    local client =
                        assert(vim.lsp.get_client_by_id(args.data.client_id))

                    local buf = args.buf

                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, {
                            buffer = buf,
                            desc = desc,
                        })
                    end

                    map("n", "K", vim.lsp.buf.hover, "LSP hover")
                    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
                    map("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
                    map("n", "gr", vim.lsp.buf.references, "Find references")
                    map("n", "gs", vim.lsp.buf.signature_help, "Signature help")
                    map("n", "gl", vim.diagnostic.open_float, "Line diagnostics")
                    map("n", "<F2>", vim.lsp.buf.rename, "Rename")
                    map({ "n", "x" }, "<F3>", function()
                        vim.lsp.buf.format({ async = true })
                    end, "Format")
                    map("n", "<F4>", vim.lsp.buf.code_action, "Code action")
                end,
            })

            -- Lua
            vim.lsp.config("lua_ls", {
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                root_markers = {
                    ".luarc.json",
                    ".luarc.jsonc",
                    ".git",
                },
                capabilities = caps,

                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },

                        diagnostics = {
                            globals = { "vim" },
                        },

                        workspace = {
                            checkThirdParty = false,
                        },

                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            -- Python
            vim.lsp.config("pyright", {
                cmd = { "pyright-langserver", "--stdio" },
                filetypes = { "python" },
                root_markers = {
                    "pyproject.toml",
                    "setup.py",
                    "setup.cfg",
                    "requirements.txt",
                    ".git",
                },
                capabilities = caps,
            })

            -- C / C++
            vim.lsp.config("clangd", {
                cmd = { "clangd" },
                filetypes = {
                    "c",
                    "cpp",
                    "objc",
                    "objcpp",
                },
                root_markers = {
                    "compile_commands.json",
                    ".clangd",
                    "Makefile",
                    ".git",
                },
                capabilities = caps,
            })

            -- Enable servers
            vim.lsp.enable({
                "lua_ls",
                "pyright",
                "clangd",
            })
        end,
    },
}
