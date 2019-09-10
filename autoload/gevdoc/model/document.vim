
function! gevdoc#model#document#new(file_path, chapters) abort
    let width = 78

    let document = {
        \ 'header': gevdoc#model#header#lines(a:file_path),
        \ 'chapters': a:chapters,
        \ 'footer': gevdoc#model#footer#lines(width),
        \ 'separater': gevdoc#model#separater#new('=', width),
        \ 'width': width,
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
            let lines += chapter.lines(self.width) + a:separater
        endfor
        return lines
    endfunction

    return document
endfunction
