vim.cmd([[
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0 " enable/disable displaying buffers with a single tab
let g:airline#extensions#tabline#switch_buffers_and_tabs = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline_section_z = "%p%% %l/%L:%c"
" let g:airline#extensions#tabline#left_sep = '^'
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#buf_label_first = 0
let g:airline#extensions#tabline#show_close_button = 0
" let g:airline#extensions#default#layout = [ [ 'a', 'b', 'c' ], [ 'x', 'y', 'z', 'error', 'warning' ] ]
" let g:airline#extensions#default#layout = [ [ 'a', 'b', 'c', 'c' ], ['c'],['x', 'y', 'z', 'error', 'warning' ] ]
" let g:airline#extensions#default#section_truncate_width = {
"       \ 'b': 79,
"       \ 'x': 60,
"       \ 'y': 88,
"       \ 'z': 45,
"       \ 'warning': 80,
"       \ 'error': 80,
"       \ }
]])
