return {
    {
        'marko-cerovac/material.nvim',
        config = function()
            --Lua:
            vim.g.material_style = "deep ocean"
            vim.cmd("colorscheme material")
        end
    },
}
