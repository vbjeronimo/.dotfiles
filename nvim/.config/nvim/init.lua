vim.o.number = true
vim.o.relativenumber = true
vim.o.colorcolumn = 80
vim.o.cursorline = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.api.nvim_create_autocmd("BufEnter", {
  --description = "Sets indentation to 2 spaces for specific filetypes",
  pattern = {"*.lua"},
  callback = function()
    vim.o.shiftwidth = 2
    vim.o.tabstop = 2
  end
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  { 
    "bluz71/vim-nightfly-colors",
    enabled = false,
		name = "nightfly",
		lazy = false,
		priority = 1000,
    config = function()
      vim.cmd("colorscheme nightfly")
    end
  },

  {
    "nvim-telescope/telescope.nvim", tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function(opts)
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>sb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, {})

      require("telescope").setup(opts)
    end
  },

}, {})
