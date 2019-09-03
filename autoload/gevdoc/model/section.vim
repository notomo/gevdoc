
function! gevdoc#model#section#all(file_lines, textwidth) abort
    let sections = []

    let comments = []
    let in_section = v:false
    for line in a:file_lines
        if in_section && match(line, '^"') != -1
            call add(comments, line[2:])
            continue
        endif

        if match(line, '^""') != -1
            call add(comments, line[3:])
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
        let tag = printf('*%s*', name)
        let spaces = repeat(' ', self.textwidth - len(tag) - len(name))
        let title = printf('%s%s%s', name, spaces, tag)
        let comments = map(copy(self.comments), {_, v -> '  ' . v})
        return [title] + comments
    endfunction

    return section
endfunction

function! s:parse(line) abort
    let factors = split(a:line, '\v\s+')
    if factors[0] =~? '^com'
        return gevdoc#model#definition#command#parse(factors)
    elseif factors[0] =~? '^hi'
        return gevdoc#model#definition#highlight_group#parse(factors)
    endif

    throw 'not supported factor: ' . factors[0]
endfunction
