
function! gevdoc#model#chapter#all(types, sections, prefix) abort
    let chapterMap = {}
    for section in a:sections
        if !has_key(chapterMap, section.type)
            let chapterMap[section.type] = []
        endif
        call add(chapterMap[section.type], section)
    endfor

    let chapters = []
    for type in a:types
        if !has_key(chapterMap, type)
            continue
        endif
        let sections = chapterMap[type]
        let chapter = gevdoc#model#chapter#new(type, sections, a:prefix)
        call add(chapters, chapter)
    endfor

    return chapters
endfunction

function! gevdoc#model#chapter#new(name, sections, prefix) abort
    let chapter = {
        \ 'name': toupper(a:name),
        \ 'prefix': a:prefix,
        \ 'sections': a:sections,
    \ }

    function! chapter.lines(width) abort
        let lines = [self.title(a:width), '']
        for section in self.sections[:-2]
            let lines += section.lines(a:width) + ['']
        endfor
        for section in self.sections[-1:]
            let lines += section.lines(a:width)
        endfor
        return lines
    endfunction

    function! chapter.title(width) abort
        let tag_name = printf('%s-%s', self.prefix, substitute(tolower(self.name), ' ', '-', 'g'))
        return gevdoc#model#tag#add(self.name, a:width, tag_name)
    endfunction

    return chapter
endfunction
