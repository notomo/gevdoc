
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
            let name = s:parse_command(line)
            let section = gevdoc#model#section#new(name, comments, a:textwidth)
            call add(sections, section)

            let comments = []
        endif
    endfor

    return sections
endfunction

function! gevdoc#model#section#new(name, comments, textwidth) abort
    let section = {
        \ 'name': a:name,
        \ 'type': 'command',
        \ 'comments': a:comments,
        \ 'textwidth': a:textwidth,
    \ }

    function! section.lines() abort
        let command = ':' . self.name
        let tag = '*' . command . '*'
        let spaces = repeat(' ', self.textwidth - len(tag) - len(command))
        let title = printf('%s%s%s', command, spaces, tag)
        return [title] + self.comments
    endfunction

    return section
endfunction

function! s:parse_command(line) abort
    for factor in split(a:line, '\v\s+')[1:]
        if factor[0] !=? '-'
            return factor
        endif
    endfor

    throw 'failed to parse command: ' . a:line
endfunction
