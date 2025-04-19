vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('RestartPrettierd', { clear = true }),
  pattern = {
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.js',
    '.prettierrc.cjs',
    '.prettierrc.yaml',
    '.prettierrc.yml',
    'prettier.config.js',
    'prettier.config.cjs',
    'package.json',
  },
  callback = function(args)
    -- Optional: only restart if we're in a project that uses prettierd
    vim.fn.system { 'prettierd', 'restart' }
    vim.notify('🌀 Restarted prettierd', vim.log.levels.INFO, { title = 'Prettierd' })
  end,
})
