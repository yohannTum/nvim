vim.cmd([[
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = 'okular'

let g:Tex_IgnoredWarnings = 
    \'Underfull'."\n".
    \'Label'."\n".
    \'specifier changed to'."\n".
    \'You have requested'."\n".
    \'Missing number, treated as zero.'."\n".
    \'There were undefined references'."\n".
    \'Citation %.%# undefined'."\n".
    \'Double space found.'."\n"
let g:Tex_IgnoreLevel = 8

let g:vimtex_quickfix_ignore_filters = [
    \'Underfull \\hbox (badness [0-9]*) in ',
    \'Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in ',
    \'Package hyperref Warning: Token not allowed in a PDF string',
    \'Package typearea Warning: Bad type area settings!',
    \"LaTeX Warning: `!h' float specifier changed to `!ht'",
    \]
]])
