" --------- "
" functions "
" --------- "

function! s:TrimLeft (text) " {{{
    return substitute(a:text, '^\s*', '', '')
endfunction " }}}

function! s:StartsWith (text, pattern) " {{{
    return a:text[:(strlen(a:pattern) - 1)] ==# a:pattern
endfunction " }}}

function! s:KindsOfCheckbox () " {{{
    if s:kinds_of_checkbox == -2
        let s:kinds_of_checkbox = index(g:todo_checkboxes, '')
        if s:kinds_of_checkbox == -1
            let s:kinds_of_checkbox = len(g:todo_checkboxes)
        endif
    endif
    return s:kinds_of_checkbox
endfunction " }}}

function! s:NextCheckbox (i) " {{{
    let l:l = s:KindsOfCheckbox()
    if a:i >= l:l
        return g:todo_checkboxes[0]
    endif
    return g:todo_checkboxes[(a:i + 1) % (l:l)]
endfunction " }}}

function! s:SetCheckbox (pspace, checkbox, text) " {{{
    " <pspace> <checkbox> <text>
    " <pspace> <checkbox> <bspace> <ttext>
    let l:cb_len = strdisplaywidth(a:checkbox)
    let l:ttext  = s:TrimLeft(a:text)
    let l:bspace = repeat(' ', &softtabstop - (l:cb_len % &softtabstop))
    call setline('.', a:pspace . a:checkbox . l:bspace . l:ttext)
endfunction " }}}

function! todo#create_checkbox (...) " {{{
    let l:uacb = (a:0 == 1) && (index(g:todo_checkboxes, a:1) >= 0)

    let l:clc = getline('.')
    let l:pspace = matchstr(l:clc, '^ *')
    let l:tclc = s:TrimLeft(l:clc)
    let l:checkbox = (l:uacb) ? (a:1) : (g:todo_checkboxes[0])

    for i in g:todo_bullets
        " iterate through predefined bullets to match string
        let l:pattern_len = strlen(g:todo_bullets[l:i])
        if s:StartsWith(l:tclc, g:todo_bullets[l:i])
            let l:text = l:tclc[(l:pattern_len):]
            call s:SetCheckbox(l:pspace, l:checkbox, l:text)
            return
        endif
    endfor

    call s:SetCheckbox(l:pspace, l:checkbox, l:tclc)
    let l:nclc = getline('.')
    call cursor(line('.'), col('.') + strlen(l:nclc) - strlen(l:clc))
endfunction "}}}

function! todo#switch_checkbox (...) " {{{
    " check if we need to use user assigned check box
    let l:uacb = (a:0 == 1) && (index(g:todo_checkboxes, a:1) >= 0)

    " current line content
    let l:clc = getline('.')
    let l:pspace = matchstr(l:clc, '^ *')
    let l:tclc = s:TrimLeft(l:clc)
    for i in range(len(g:todo_checkboxes))
        " iterate through predefined checkboxes to match string
        let l:pattern_len = strlen(g:todo_checkboxes[l:i])
        if s:StartsWith(l:tclc, g:todo_checkboxes[l:i])
            " found a checkbox, switch it to next checkbox
            let l:text = l:tclc[(l:pattern_len):]
            let l:checkbox = (l:uacb) ? (a:1) : (s:NextCheckbox(l:i))
            call s:SetCheckbox(l:pspace, l:checkbox, l:text)
            return
        endif
    endfor

    if l:uacb
        call todo#create_checkbox(a:1)
    else
        call todo#create_checkbox()
    endif
endfunction " }}}

function! todo#increase_indent () " {{{
    let l:clc = getline('.')
    let l:pspace_len = strlen(matchstr(l:clc, '^ *'))
    let l:prepend_len = l:pspace_len % shiftwidth()
    let l:prepend_len = shiftwidth() - ((l:prepend_len == 0) ? 0 : (l:prepend_len))
    call setline('.', repeat(' ', l:prepend_len) . l:clc)
    call cursor(line('.'), col('.') + &shiftwidth)
endfunction " }}}

function! todo#decrease_indent () " {{{
    let l:clc = getline('.')
    let l:pspace_len = strlen(matchstr(l:clc, '^ *'))
    if l:pspace_len == 0
        return
    endif
    let l:trim_len = (l:pspace_len % shiftwidth())
    if l:trim_len == 0
        let l:trim_len = shiftwidth()
    endif
    call cursor(line('.'), col('.') - &shiftwidth)
    call setline('.', l:clc[(l:trim_len):])
endfunction " }}}

function! todo#create_bullet () " {{{
    let l:clc = getline('.')
    let l:pspace = matchstr(l:clc, '^ *')
    if strlen(l:pspace) == 0
        let l:pspace = matchstr(getline(line('.') - 1), '^ *')
    endif
    let l:bspace = repeat(' ', &softtabstop - strdisplaywidth(g:todo_bullets[0]))
    call setline('.', l:pspace . g:todo_bullets[0] . l:bspace . s:TrimLeft(l:clc))
    call cursor(line('.'), col('.') + strdisplaywidth(g:todo_bullets[0] . l:bspace))
endfunction " }}}

function! todo#open_new_line () " {{{
    let l:row = line('.')
    let l:col = col('.')
    call append(l:row, '')
    let l:row = l:row + 1
    call cursor(l:row, l:col)
    call todo#create_bullet()
endfunction " }}}

let s:kinds_of_checkbox = -2
