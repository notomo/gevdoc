
function! gevdoc#model#section#all(file_lines, width) abort
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
            let section = gevdoc#model#section#new(definition, comments, a:width)
            call add(sections, section)

            let comments = []
        endif
    endfor

    return sections
endfunction

function! gevdoc#model#section#new(definition, comments, width) abort
    let section = {
        \ 'definition': a:definition,
        \ 'type': a:definition.type,
        \ 'comments': a:comments,
        \ 'width': a:width,
    \ }

    function! section.lines() abort
        let name = self.definition.name
        let tag_name = !has_key(self.definition, 'tag_name') ? name : self.definition.tag_name
        let title = gevdoc#model#tag#add(name, self.width, tag_name)
        let comments = map(copy(self.comments), {_, v -> '  ' . v})
        return [title] + comments
    endfunction

    return section
endfunction
