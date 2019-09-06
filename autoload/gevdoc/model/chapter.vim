
function! gevdoc#model#chapter#all(types, plugin_path, prefix, width, excluded_pattern) abort
    let sections = []

    let paths = glob(a:plugin_path . '**/*.vim', v:true, v:true)
    call map(paths, {_, path -> fnamemodify(path, ':.')})
    if !empty(a:excluded_pattern)
        call filter(paths, {_, path -> path !~# a:excluded_pattern })
    endif

    for path in paths
        let file = readfile(path)
        let sections += gevdoc#model#section#all(file, a:width)
    endfor

    let chapterMap = {}
    for section in sections
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
        let chapter = gevdoc#model#chapter#new(type, sections, a:prefix, a:width)
        call add(chapters, chapter)
    endfor

    return chapters
endfunction

function! gevdoc#model#chapter#new(name, sections, prefix, width) abort
    let chapter = {
        \ 'name': toupper(a:name),
        \ 'prefix': a:prefix,
        \ 'sections': a:sections,
        \ 'width': a:width,
    \ }

    function! chapter.lines() abort
        let lines = [self.title(), '']
        for section in self.sections[:-2]
            let lines += section.lines() + ['']
        endfor
        for section in self.sections[-1:]
            let lines += section.lines()
        endfor
        return lines
    endfunction

    function! chapter.title() abort
        let tag_name = printf('%s-%s', self.prefix, substitute(tolower(self.name), ' ', '-', 'g'))
        return gevdoc#model#tag#add(self.name, self.width, tag_name)
    endfunction

    return chapter
endfunction
