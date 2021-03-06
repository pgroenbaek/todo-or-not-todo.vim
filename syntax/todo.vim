if !exists('b:todo_checkbox_all')
    finish
endif

set background=dark

syn match   todo_string _\v"([^\\"]|\\.)*"_
hi def      todo_string ctermfg=Magenta

syn match   todo_emphasis   _\v\*[^*]*\*_
hi def      todo_emphasis   ctermfg=White

syn match   todo_strong_emphasis    _\v\*\*.{-}\*\*_
hi def      todo_strong_emphasis    ctermfg=Red

if g:todo_url_color !=# '' && g:todo_url_pattern !=# ''
    execute 'syn match todo_url _'. g:todo_url_pattern .'_'
    execute 'hi def todo_url ctermfg='. g:todo_url_color
endif

" ---------------------------------------- "
" dynamically generate bullet color syntax "
" ---------------------------------------- "
if g:todo_bullet !=# ''
    execute 'syn match todo_bulleted_item _\v(^\s*)@<=\V'. g:todo_bullet .'_'
endif

if g:todo_bullet_color !=# ''
    execute 'hi def todo_bulleted_item ctermfg='. g:todo_bullet_color
endif

" TODO: group names should be checked
for c in keys(b:todo_checkbox_color)
    if c != '' && b:todo_checkbox_color[c] != ''
        execute 'hi def    '. tolower(b:todo_checkbox_color[c]) .'_checkbox ctermfg='. b:todo_checkbox_color[c] .''
        execute 'syn match '. tolower(b:todo_checkbox_color[c]) .'_checkbox _\v(^ *)@<=\V'. c .'_'
    endif
endfor

if g:todo_comment_prefix !=# ''
    execute 'syn match todo_comment _\V'. g:todo_comment_prefix .'\v.*$_'
endif

if g:todo_comment_color !=# ''
    execute 'hi def    todo_comment ctermfg='. g:todo_comment_color
endif

if g:todo_highlighter_start !=# '' && g:todo_highlighter_end !=# ''
    execute 'syn match todo_highlighter_symbol _\v['. g:todo_highlighter_start . g:todo_highlighter_end .']_ conceal'
    execute 'syn match todo_highlighter _\v('. g:todo_highlighter_start .')@<='.
            \'[^'. g:todo_highlighter_start . g:todo_highlighter_end .']*'.
            \'('. g:todo_highlighter_end .')@=_'
endif

if g:todo_highlighter_color !=# ''
    execute 'hi def    todo_highlighter ctermfg=Black ctermbg='. g:todo_highlighter_color
endif
