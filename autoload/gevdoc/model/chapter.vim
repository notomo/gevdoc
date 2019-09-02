
let s:TYPE_COMMAND = 'command'

function! gevdoc#model#chapter#all(plugin_path, prefix, textwidth, excluded_pattern) abort
    let sections = []

    let paths = glob(a:plugin_path . '**/*.vim', v:true, v:true)
    call map(paths, {_, path -> fnamemodify(path, ':.')})
    if !empty(a:excluded_pattern)
        call filter(paths, {_, path -> path !~# a:excluded_pattern })
    endif

    for path in paths
        let file = readfile(path)
        let sections += gevdoc#model#section#all(file, a:textwidth)
    endfor

    let chapterMap = {}
    for section in sections
        if !has_key(chapterMap, section.type)
            let chapterMap[section.type] = []
        endif
        call add(chapterMap[section.type], section)
    endfor

    let chapters = []
    if has_key(chapterMap, s:TYPE_COMMAND)
        let chapter = gevdoc#model#chapter#new('commands', chapterMap[s:TYPE_COMMAND], a:prefix, a:textwidth)
        call add(chapters, chapter)
    endif

    return chapters
endfunction

function! gevdoc#model#chapter#new(name, sections, prefix, textwidth) abort
    let chapter = {
        \ 'name': toupper(a:name),
        \ 'prefix': a:prefix,
        \ 'sections': a:sections,
        \ 'textwidth': a:textwidth,
    \ }

    function! chapter.lines() abort
        let lines = [self.title(), '']
        for section in self.sections
            let lines += section.lines() + ['']
        endfor
        return lines
    endfunction

    function! chapter.title() abort
        let tag = printf('*%s-%s*', self.prefix, tolower(self.name))
        let spaces = repeat(' ', self.textwidth - len(tag) - len(self.name))
        return printf('%s%s%s', self.name, spaces, tag)
    endfunction

    return chapter
endfunction
