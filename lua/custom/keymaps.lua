-- Move selected lines up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move 1 line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move 1 line up' })

-- Join lines without losing cursor
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines keeping cursor' })

-- Keep search terms centered
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next match centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev match centered' })

-- Center screen on scroll
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up centered' })

-- Disable Q
vim.keymap.set('n', 'Q', '<nop>', { desc = 'Just no.' })
