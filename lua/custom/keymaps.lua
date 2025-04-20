vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move 1 line up' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move 1 line down' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Append next line to current line without losing the cursor position' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Keep current search item centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Keep current search item centered' })

vim.keymap.set('n', 'Q', '<nop>', { desc = 'Just no.' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center page on half page down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center page on half page up' })
