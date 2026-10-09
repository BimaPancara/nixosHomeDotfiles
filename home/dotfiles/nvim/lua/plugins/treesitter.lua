return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install({
            "lua",
            "python",
	    "c",
	    "vhdl",
	    "markdown",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "lua", "python" },
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
