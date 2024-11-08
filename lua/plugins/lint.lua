return {{
    "mfussenegger/nvim-lint",
    event = {"BufReadPre", "BufNewFile"},
    config = function(_, opts)
        local lint = require("lint")
        lint.linters.jq = {
            cmd = "jq",
            stdin = true,
            args = {"."},
            stream = "both",
            ignore_exitcode = true,
            parser = function(output, stderr)
                local result = {}
                -- Only process if stderr contains a non-empty string (error message)
                if stderr and type(stderr) == "string" and stderr ~= "" then
                    table.insert(result, {
                        lnum = 1,
                        col = 1,
                        message = stderr, -- Make sure this is a string
                        severity = vim.diagnostic.severity.ERROR
                    })
                end
                return result
            end
        }
        -- Define a function that checks if a linter is available in the PATH
        local function linter_exists(linter)
            return vim.fn.executable(linter) == 1
        end

        -- Assign linters by file type
        lint.linters_by_ft = opts.linters_by_ft

        -- Create autocommand group for linting
        local lint_augroup = vim.api.nvim_create_augroup("lint", {
            clear = true
        })
        vim.api.nvim_create_autocmd(opts.events, {
            group = lint_augroup,
            callback = function()
                local ft = vim.bo.filetype
                local linters = opts.linters_by_ft[ft]

                if linters then
                    for _, linter in ipairs(linters) do
                        if not linter_exists(linter) then
                            return -- Skip linting if any required linter is missing
                        end
                    end
                    lint.try_lint() -- Run linting if all linters for the filetype are available
                end
            end
        })

        -- Optional keymap to manually trigger linting
        vim.keymap.set("n", "<leader>L", function()
            lint.try_lint()
        end, {
            desc = "Trigger linting for current file"
        })
    end,
    opts = {
        events = {"BufWritePost"},
        linters_by_ft = {
            fish = {"fish"},
            javascript = {"eslint_d"},
            typescript = {"eslint_d"},
            javascriptreact = {"eslint_d"},
            typescriptreact = {"eslint_d"},
            svelte = {"eslint_d"},
            python = {"pylint"},
            markdown = {"vale"},
            go = {"golangcilint"},
            json = {"jq"}
        },
        linters = {
            selene = {
                condition = function(ctx)
                    return vim.fs.find({"selene.toml"}, {
                        path = ctx.filename,
                        upward = true
                    })[1]
                end
            }
        }
    }
}}
