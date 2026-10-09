return {
{
"ThePrimeagen/harpoon",
branch = "harpoon2",
dependencies = {
"nvim-lua/plenary.nvim",
"nvim-telescope/telescope.nvim",
},

    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        -- Add current file to Harpoon
       vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Harpoon add file" })

	-- Remove current file from Harpoon
	vim.keymap.set("n", "<leader>d", function()
	    harpoon:list():remove()
	end, { desc = "Harpoon remove file" })

	-- Harpoon's normal quick menu
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon menu" })

        -- Previous / next Harpoon file
        vim.keymap.set("n", "<C-p>", function()
            harpoon:list():prev()
        end, { desc = "Harpoon previous" })

        vim.keymap.set("n", "<C-n>", function()
            harpoon:list():next()
        end, { desc = "Harpoon next" })

        -- Harpoon list in Telescope
        vim.keymap.set("n", "<leader>fl", function()
            local conf = require("telescope.config").values
            local themes = require("telescope.themes")

	    local file_paths = {}

            for _, item in ipairs(harpoon:list().items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers")
                .new(
                    themes.get_ivy({
                        prompt_title = "Harpoon",
                    }),
                    {
                        finder = require("telescope.finders").new_table({
                            results = file_paths,
                        }),

                        previewer = conf.file_previewer({}),

                        sorter = conf.generic_sorter({}),
                    }
                )
                :find()
        end, { desc = "Harpoon Telescope" })
    end,
},

}

