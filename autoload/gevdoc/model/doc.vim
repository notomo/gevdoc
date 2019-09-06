
function! gevdoc#model#doc#new(plugin_path, options) abort
    let plugin_path = fnamemodify(a:plugin_path, ':p')
    let name = fnamemodify(plugin_path, ':h:t')
    let file_path = plugin_path . 'doc/' . name . '.txt'

    let excluded_pattern = join(a:options['exclude'], '\|\m')

    let doc = {
        \ 'name': name,
        \ 'plugin_path': plugin_path,
        \ 'file_path': file_path,
        \ 'width': 78,
        \ 'chapter_types': a:options['chapters'],
        \ 'excluded_pattern': excluded_pattern,
    \ }

    function! doc.lines() abort
        let sep = self.separater()
        return
            \ gevdoc#model#header#lines(self.file_path) +
            \ sep +
            \ self.body(sep) +
            \ gevdoc#model#footer#lines(self.width)
    endfunction

    function! doc.body(sep) abort
        let lines = []
        for chapter in gevdoc#model#chapter#all(self.chapter_types, self.plugin_path, self.name, self.width, self.excluded_pattern)
            let lines += chapter.lines() + a:sep
        endfor
        return lines
    endfunction

    function! doc.separater() abort
        return ['', repeat('=', self.width)]
    endfunction

    return doc
endfunction
