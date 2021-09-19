local map = vim.api.nvim_set_keymap

map('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true })
map('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true })
map('n', '[c', '<Plug>(coc-diagnostic-prev)', { noremap = false})
map('n', ']c', '<Plug>(coc-diagnostic-next)', { noremap = false})
map('n', 'gd', '<Plug>(coc-definition)', { noremap = false})
map('n', 'gr', '<Plug>(coc-references)', { noremap = false})
map('n', 'gi', '<Plug>(coc-implementation)', { noremap = false})
map('n', 'K', ':call <SID>show_documentation()<CR>', { noremap = true})
map('n', 'rn', '<Plug>(coc-rename)', { noremap = false})
map('n', '<leader>a', '<Plug>(coc-codeaction-selected)', { noremap = false})
map('x', '<leader>a', '<Plug>(coc-codeaction-selected)', { noremap = false})
