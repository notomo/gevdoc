
function! gevdoc#model#doc#new(plugin_path, options) abort
    let plugin_path = fnamemodify(a:plugin_path, ':p')
    let name = fnamemodify(plugin_path, ':h:t')
    let file_path = plugin_path . 'doc/' . name . '.txt'

    let excluded_pattern = join(a:options['exclude'], '\|\m')

    let doc = {
        \ 'name': name,
        \ 'plugin_path': plugin_path,
        \ 'file_path': file_path,
        \ 'textwidth': 78,
        \ 'excluded_pattern': excluded_pattern,
    \ }

    function! doc.lines() abort
        let sep = self.separater()
        return
            \ gevdoc#model#header#lines(self.file_path) +
            \ sep +
            \ self.body(sep) +
            \ gevdoc#model#footer#lines(self.textwidth)
    endfunction

    function! doc.body(sep) abort
        let lines = []
        for chapter in gevdoc#model#chapter#all(self.plugin_path, self.name, self.textwidth, self.excluded_pattern)
            let lines += chapter.lines() + a:sep
        endfor
        return lines
    endfunction

    function! doc.separater() abort
        return ['', repeat('=', self.textwidth)]
    endfunction

    return doc
endfunction
