
function! gevdoc#model#section#all(file_lines) abort
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
            let definition = gevdoc#model#definition#definition#parse(line)
            let section = gevdoc#model#section#new(definition, comments)
            call add(sections, section)

            let comments = []
        endif
    endfor

    return sections
endfunction

function! gevdoc#model#section#external(file) abort
    let section = {
        \ 'type': a:file.name(),
        \ '_file': a:file,
    \ }

    function! section.lines(width) abort
        if !self._file.is_code()
            return self._file.read()
        endif

        let lines = []
        for line in self._file.read()
            if empty(line)
                call add(lines, line)
                continue
            endif
            call add(lines, '  ' . line)
        endfor
        return ['>'] + lines + ['<']
    endfunction

    return [section]
endfunction

function! gevdoc#model#section#new(definition, comments) abort
    let section = {
        \ 'definition': a:definition,
        \ 'type': a:definition.type,
        \ 'comments': a:comments,
        \ '_in_code': v:false,
    \ }

    function! section.lines(width) abort
        let name = self.definition.name
        let tag_name = !has_key(self.definition, 'tag_name') ? name : self.definition.tag_name
        let title = gevdoc#model#tag#add(name, a:width, tag_name)

        let comments = map(copy(self.comments), {_, v -> self._make(v)})

        return [title] + comments
    endfunction

    function! section._make(line) abort
        if a:line ==? '```'
            let in_code = self._in_code
            let self._in_code = !in_code
            return in_code ? '<' : '>'
        endif
        return '  ' . a:line
    endfunction

    return section
endfunction
