" My vimrc file
" (c) Ernest Esene <eroken1@gmail.com>
" See LICENSE file
"
" For AVR see AvrALE()
"
" Based on example vimrc by Bram Moolenaar <Bram@vim.org>
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? 'evim'
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has('vms')
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has('gui_running')
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has('autocmd')

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
set textwidth=80

" Add optional packages.
"
" The matchit plug-in makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" My vimrc starts here
set tabstop=2
set cindent shiftwidth=2
set expandtab
set spell spelllang=en_gb
"highlight SpellLocal term=underline ctermbg=14 gui=undercurl guisp=Cyan
highlight SpellLocal term=underline ctermbg=14 gui=undercurl guisp=Cyan ctermfg=0 guifg=Black
" for backup files
set backupdir=/run/user/$UID,/tmp
" for swap files
set directory=/run/user/$UID,/tmp
" for undo files
set undodir=/run/user/$UID,/tmp
" set i_CTRL-N for local keyword only
inoremap <c-n> <c-x><c-n>
" i_CTRL_P for normal behaviour of i_CTRL-N
set complete =.,w,b,u
"Search path for custom toolchain
"used by gf, [f, ]f :find :sfind :tabfind
" '.' is current dir of file, ',' is parent dir of file
"set path=.,/usr/include,,
"set mouse=nvi




"Clang_complete (mix with ALE to get Youcompleteme feature
"disable clang_complete
set conceallevel=2
set concealcursor=vin
let g:clang_snippets=1
let g:clang_conceal_snippets=1
"let g:clang_snippets_engine='clang_complete'
"UltiSnip engine can't re-edit after leaving the line
let g:clang_snippets_engine='ultisnips'
let g:clang_complete_macros=1
let g:clang_complete_patterns=1
"enable omnicppcomplete, will disable g:clang_complete_auto
let g:clang_omnicppcomplete_compliance=1
"set i_CTRL-[ for user defined completion
"inoremap <c-[> <c-x><c-u>

" Complete options (disable preview scratch window, longest removed to aways
" show menu)
set completeopt=menu,menuone,preview

" Limit popup menu height
set pumheight=5

" SuperTab completion fall-back Not yet installed
"let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'

"End clang_complete==============

" ALE=========
let g:ale_enabled=1
"set omnifunc=ale#completion#OmniFunc " TODO: replace Clang_complete
let g:ale_completion_enabled=1
let g:ale_completion_delay=1000
let g:ale_echo_delay = 1000
let g:ale_cursor_detail=1
let g:ale_echo_cursor=0
let g:ale_history_enabled = 0 "Expensive
let g:ale_history_log_output = 0 "Expensive
"let g:ale_set_loclist=0
let g:ale_cache_executable_check_failures=1
let g:ale_lsp_suggestions = 1

" linters
let g:ale_lint_delay=4000
let g:ale_lint_on_enter=0
let g:ale_lint_on_save=1
let g:ale_lint_on_filetype_changed=0
"let g:ale_c_always_make=0
let g:ale_c_parse_makefile=1
"let g:ale_c_cc_executable='gcc'
"let g:ale_cpp_cc_executable='gcc'
let g:ale_c_clangd_options='--clang-tidy --pch-storage=memory'
"let g:ale_linters = {'c':['cc','clangtidy','cppcheck','flawfinder']}
let g:ale_linters = {'c':['clangd','cppcheck','flawfinder']}
let g:ale_linters['cpp'] = g:ale_linters['c']

" fixers
let g:ale_fix_on_save=1
let g:ale_c_clangformat_options='--style="{BasedOnStyle: google}"'
let g:ale_fixers = {'c':['clang-format']}
let g:ale_fixers['cpp'] = g:ale_fixers['c']
let g:ale_fixers['javascript'] =  ['prettier']
let g:ale_fixers['json'] =  ['prettier']
let g:ale_fixers['sh'] =  ['shfmt']

"ale HACK
"/usr/share/vim/vimfiles/autoload/ale/completion.vim
" HACK: don't close preview window after completion
" function! ale#completion#Done() abort
"   "silent! pclose
"
"
"HACK: show function signature on ale completion preview window
" add the line with + in the function below
" function! ale#completion#ParseLSPCompletions(response) abort
"
"   let l:detail = substitute(get(l:item, 'detail', ''), '\_s\+', ' ', 'g')
" + let l:doc = l:detail . get(l:item, 'label', '') . ' -> ' . l:doc
"   let l:result = {
"   \   'word': l:word,
"   \   'kind': ale#completion#GetCompletionSymbols(get(l:item, 'kind', '')),


" END ALE=========

" doxygen
"nnoremap <silent> <F8> :set filetype=cpp.doxygen<CR>
"nnoremap <silent> <F9> :set filetype=cpp<CR>
let g:load_doxygen_syntax=1
"you can put this at the end of your source code
"	// vim:syntax=c.doxygen
"To automatically enable doxyen syntax highlighting for c source code

" NERDTree
"nnoremap <silent> <F7> :NERDTreeToggle<CR>

" Tagbar
"nnoremap <silent> <F6> :TagbarToggle<CR>

"UlitSnip==========
"may interfare with i_-
"inoremap <c-x><c-k> <c-x><c-k>
"

"gitgutter ======
"let g:gitgutter_enabled = 0


"Ctags and omnicomplete
"use i_
"use 
"
"generate with make
"tags: ctags -R --kinds-C=+pxD *.h *.c
"TAGS: ctags -R  --kinds-C=+px -f TAGS /usr/avr/include
"Generate systags
"ctags -R  --kinds-C=m   -f ~/.vim/vimgit/systags\
"/usr/include/sys /usr/include/*.h /usr/include/bits /usr/include/asm /usr/include/linux
"
" check AVR section
set tags=tags,~/.vim/vimgit/systags

"Cscope
"use cstag instead of tag (cscope + ctag)
set cscopetag

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>a :cs find a <C-R>=expand("<cword>")<CR><CR>
"
"" Using 'CTRL-spacebar' then a search type makes the vim window
"" split horizontally, with search result displayed in
"" the new window.
"nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space>a :scs find a <C-R>=expand("<cword>")<CR><CR>
"                                                                    
"" Hitting CTRL-space *twice* before the search type does a vertical
"" split instead of a horizontal one
"nmap <C-Space><C-Space>s
"	\:vert scs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>g
"	\:vert scs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>c
"	\:vert scs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>t
"	\:vert scs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>e
"	\:vert scs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>i
"	\:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <C-Space><C-Space>d
"	\:vert scs find d <C-R>=expand("<cword>")<CR><CR>
"nmap <C-Space><C-Space>a
	\:vert scs find a <C-R>=expand("<cword>")<CR><CR>

" AVR =========
" NOTE: to enable avr support use any of this, both is better
" 1. :call AvrALE()  in your vim
" 2. Add Makefile to you Makefile and run make complete
"
" Makefile is this repo
" https://github.com/ernestesene/vimrc.git
"
echo 'call AvrALE() to enable AVR support'
let s:avrALE_loaded=0
function AvrALE()
 if s:avrALE_loaded
   echo 'AvrALE() already activated'
   return
 endif
 let g:ale_c_cc_executable='avr-gcc'
 let g:ale_asm_gcc_executable='avr-gcc'
 let g:ale_cpp_cc_executable='avr-gcc'
 let g:ale_linters = {'c':['cc','clangd','cppcheck','flawfinder']}
 let g:ale_linters['cpp'] = g:ale_linters['c']

 "clang_complete
 let g:clang_user_options='-I/usr/avr/include -I/usr/include/simavr/avr'
 " TODO how about -D__AVR_AT.* for .clang_complete?

  set path=.,,/usr/avr/include,/usr/include/simavr/avr

"ctags -R  --kinds-C=+pxD -f ~/.vim/vimgit/avrtags /usr/avr/include
"/usr/include/simavr/avr
 set tags-=~/.vim/vimgit/systags
 set tags+=~/.vim/vimgit/avrtags

 let s:avrALE_loaded=1
 return
endfunction

" arduino =======
function s:arduinoALE()
  set filetype+=.cpp
  call AvrALE()
  return
endfunction

augroup my_vimrc
  autocmd!
  au FileType arduino call s:arduinoALE()
  au BufNewFile,BufRead *.gdb setf gdb
augroup END
