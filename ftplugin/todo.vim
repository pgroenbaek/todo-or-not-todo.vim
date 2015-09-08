" ----------------------------------- "
" extract and set tab related options "
" ----------------------------------- "

if &softtabstop == 0
    " user not setting &softtabstop, set it to 4
    setlocal softtabstop=4
endif

if shiftwidth() == 8
    " user not setting &shiftwidth, set it to 4
    setlocal shiftwidth=4
endif

" -------- "
" mappings "
" -------- "

nnoremap <buffer> <silent> <C-c> :call todo#SwitchCheckbox()<CR>
inoremap <buffer> <silent> <C-c> <C-o>:call todo#SwitchCheckbox()<CR>

nnoremap <buffer> <silent> > :call todo#IncreaseIndent()<CR>
nnoremap <buffer> <silent> < :call todo#DecreaseIndent()<CR>
vnoremap <buffer> <silent> > :call todo#IncreaseIndent()<CR>gv
vnoremap <buffer> <silent> < :call todo#DecreaseIndent()<CR>gv

nnoremap <buffer> <silent> o :call todo#OpenNewLine()<CR>A

" --------------------- "
" set default variables "
" --------------------- "

function! s:IsNotStringArray (ary) " {{{
    if type(a:ary) != type([])
        return 1
    endif
    for i in a:ary
        if type(l:i) != type('')
            return 1
        endif
    endfor

    return 0
endfunction " }}}

if !exists('g:todo_checkboxes') || s:IsNotStringArray(g:todo_checkboxes)
    let g:todo_checkboxes = ['[ ]', '[v]', '[x]', '', '[i]', '[?]', '[!]']
endif

if !exists('g:todo_bulleted_items') || s:IsNotStringArray(g:todo_bulleted_items)
    let g:todo_bulleted_items = ['>']
endif

if !exists('g:todo_bullet_color') || type(g:todo_bullet_color) != type('')
    let g:todo_bullet_color = 'cyan'
endif
