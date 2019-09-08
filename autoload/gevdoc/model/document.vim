
function! gevdoc#model#document#new(file_path, width, chapters) abort
    let document = {
        \ 'header': gevdoc#model#header#lines(a:file_path),
        \ 'chapters': a:chapters,
        \ 'footer': gevdoc#model#footer#lines(a:width),
        \ 'separater': gevdoc#model#separater#new('=', a:width)
    \ }

    function! document.lines() abort
        return
            \ self.header +
            \ self.separater +
            \ self.body(self.separater) +
            \ self.footer
    endfunction

    function! document.body(separater) abort
        let lines = []
        for chapter in self.chapters
            let lines += chapter.lines() + a:separater
        endfor
        return lines
    endfunction

    return document
endfunction
