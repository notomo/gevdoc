
function! gevdoc#model#section#all(file_lines, textwidth) abort
    let sections = []

    let comments = []
    let in_section = v:false
    for line in a:file_lines
        let comment = matchstr(line, '^\s*\zs".*')
        if in_section && !empty(comment)
            call add(comments, comment[2:])
            continue
        endif

        let doc_start_comment = matchstr(line, '^\s*\zs"".*')
        if !empty(doc_start_comment)
            call add(comments, doc_start_comment[3:])
            let in_section = v:true
            continue
        endif

        let in_section = v:false
        if !empty(comments)
            let definition = s:parse(line)
            let section = gevdoc#model#section#new(definition, comments, a:textwidth)
            call add(sections, section)

            let comments = []
        endif
    endfor

    return sections
endfunction

function! gevdoc#model#section#new(definition, comments, textwidth) abort
    let section = {
        \ 'definition': a:definition,
        \ 'type': a:definition.type,
        \ 'comments': a:comments,
        \ 'textwidth': a:textwidth,
    \ }

    function! section.lines() abort
        let name = self.definition.name
        let title = gevdoc#model#tag#add(name, self.textwidth)
        let comments = map(copy(self.comments), {_, v -> '  ' . v})
        return [title] + comments
    endfunction

    return section
endfunction

function! s:parse(line) abort
    let factors = split(a:line, '\v\s+')
    if factors[0] =~# '^com'
        return gevdoc#model#definition#command#parse(factors)
    elseif factors[0] =~# '^hi'
        return gevdoc#model#definition#highlight_group#parse(factors)
    elseif factors[0] =~# '^\w*noremap'
        return gevdoc#model#definition#plug_mapping#parse(factors)
    elseif len(factors) > 2 && factors[0] ==# 'let' && factors[1] =~# '^[gb]:'
        return gevdoc#model#definition#variable#parse(factors)
    endif

    throw 'not supported factor: ' . factors[0]
endfunction
