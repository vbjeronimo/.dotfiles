-- vim.api.nvim_create_autocmd('BufWritePre', {
-- 	pattern = '*.go',
-- 	callback = function()
-- 		vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
-- 	end
-- })
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
  pattern = { "*.md", "*.txt" },
  callback = function()
    vim.opt.wrap = true
    vim.opt.linebreak = true
  end,
})

-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = "*.lua",
--   callback = function()
--     vim.opt.shiftwidth = 2
--     vim.opt.tabstop = 2
--   end,
-- })
