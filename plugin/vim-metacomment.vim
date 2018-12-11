" vim-metacomment.vim
"
"
" The MIT License (MIT)
"
" Copyright (c) 2013-2016 Jean Guyomarc'h
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
"


" -------------------------------------------------------------------------- "
"                           Configuration Variables                          "
" -------------------------------------------------------------------------- "

" C and derivates (type /* */)
if !exists("g:MetaComment_header_c")
   let g:MetaComment_header_c = "============================================================================*"
endif

if !exists("g:MetaComment_right_c")
   let g:MetaComment_right_c = "*"
endif

if !exists("g:MetaComment_left_c")
   let g:MetaComment_left_c = "*"
endif

if !exists("g:MetaComment_footer_c")
   let g:MetaComment_footer_c = "*============================================================================"
endif

" C++ (type //)
if !exists("g:MetaComment_header_cpp")
   let g:MetaComment_header_cpp = "============================================================================//"
endif

if !exists("g:MetaComment_right_cpp")
   let g:MetaComment_right_cpp = "//"
endif

if !exists("g:MetaComment_left_cpp")
   let g:MetaComment_left_cpp = ""
endif

if !exists("g:MetaComment_footer_cpp")
   let g:MetaComment_footer_cpp = "============================================================================//"
endif

" Shell/Python/Ruby (type #)
if !exists("g:MetaComment_header_sh")
   let g:MetaComment_header_sh = "==============================================================================#"
endif

if !exists("g:MetaComment_right_sh")
   let g:MetaComment_right_sh = " #"
endif

if !exists("g:MetaComment_left_sh")
   let g:MetaComment_left_sh = " "
endif

if !exists("g:MetaComment_footer_sh")
   let g:MetaComment_footer_sh = "==============================================================================#"
endif

" Assembler (type ;)
if !exists("g:MetaComment_header_asm")
   let g:MetaComment_header_asm = " ---------------------------------------------------------------------------- ;"
endif

if !exists("g:MetaComment_right_asm")
   let g:MetaComment_right_asm = " ;"
endif

if !exists("g:MetaComment_left_asm")
   let g:MetaComment_left_asm = " "
endif

if !exists("g:MetaComment_footer_asm")
   let g:MetaComment_footer_asm = " ---------------------------------------------------------------------------- ;"
endif

" Vimscript (type ")
if !exists("g:MetaComment_header_vim")
   let g:MetaComment_header_vim = " ---------------------------------------------------------------------------- \""
endif

if !exists("g:MetaComment_right_vim")
   let g:MetaComment_right_vim = " \""
endif

if !exists("g:MetaComment_left_vim")
   let g:MetaComment_left_vim = " "
endif

if !exists("g:MetaComment_footer_vim")
   let g:MetaComment_footer_vim = " ---------------------------------------------------------------------------- \""
endif

" VHDL (tpye --)
if !exists("g:MetaComment_header_vhdl")
   let g:MetaComment_header_vhdl = " -------------------------------------------------------------------------- --"
endif

if !exists("g:MetaComment_right_vhdl")
   let g:MetaComment_right_vhdl = "--"
endif

if !exists("g:MetaComment_left_vhdl")
   let g:MetaComment_left_vhdl = ""
endif

if !exists("g:MetaComment_footer_vhdl")
   let g:MetaComment_footer_vhdl = " -------------------------------------------------------------------------- --"
endif

" LaTeX (type %)
if !exists("g:MetaComment_header_latex")
   let g:MetaComment_header_latex = " ---------------------------------------------------------------------------- %"
endif

if !exists("g:MetaComment_right_latex")
   let g:MetaComment_right_latex = " %"
endif

if !exists("g:MetaComment_left_latex")
   let g:MetaComment_left_latex = " "
endif

if !exists("g:MetaComment_footer_latex")
   let g:MetaComment_footer_latex = " ---------------------------------------------------------------------------- %"
endif

" HTML (type <!-- -->)
if !exists("g:MetaComment_header_html")
   let g:MetaComment_header_html = " ***************************************************************************"
endif

if !exists("g:MetaComment_right_html")
   let g:MetaComment_right_html = " *"
endif

if !exists("g:MetaComment_left_html")
   let g:MetaComment_left_html = "*"
endif

if !exists("g:MetaComment_footer_html")
   let g:MetaComment_footer_html = "*************************************************************************** "
endif

" Jinja (type {# #}
if !exists("g:MetaComment_header_jinja")
   let g:MetaComment_header_jinja = "#############################################################################"
endif

if !exists("g:MetaComment_right_jinja")
   let g:MetaComment_right_jinja = "#"
endif

if !exists("g:MetaComment_left_jinja")
   let g:MetaComment_left_jinja = "#"
endif

if !exists("g:MetaComment_footer_jinja")
   let g:MetaComment_footer_jinja = "#############################################################################"
endif

" all (type {# #}
if !exists("g:MetaComment_header_all")
   let g:MetaComment_header_all = ""
endif

if !exists("g:MetaComment_right_all")
   let g:MetaComment_right_all = "#"
endif

if !exists("g:MetaComment_left_all")
   let g:MetaComment_left_all = "#"
endif

if !exists("g:MetaComment_footer_all")
   let g:MetaComment_footer_all = ""
endif

" -------------------------------------------------------------------------- "
"                                 Private API                                "
" -------------------------------------------------------------------------- "

function! StringWithWhiteSpaces(str)
   let right = ""
   let left = ""
   let space = 76
   let len = strlen(a:str)
   let leftspace = (space - len) / 2
   let rightspace = leftspace
   let c = 0

   if (len % 2 != 0)
      let leftspace += 1
   endif

   while c < rightspace
      let right = right . " "
      let c += 1
   endwhile
   let c = 0
   while c < leftspace
      let left = left . " "
      let c += 1
   endwhile

   return left . a:str . right
endfunction

function! MultiStringWithMeta(str,left, right) 
   let content = ""
   let linecon = ""
   let right = ""
   let left = a:left
   let space = 76

   if a:right == ''
       let space = 0
   else
       let right = a:right
   endif

   let start = 0
   let newstart = stridx(a:str, "\n", start)
   while (newstart  > 0)
       let linecon = strpart(a:str, start, newstart - start)
       let len = strlen(linecon)
       let rightspace = space - len
       let c = 0

       while c < rightspace
           let right = " " . right
           let c += 1
       endwhile
       let c = 0
       let content = left . linecon . right . "\n"
       exec "normal 0d$i" . content
       let start = newstart + 1
       let right = a:right
       let newstart = stridx(a:str, "\n", start)
   endwhile
   "return content
endfunction

function! StringWithWhiteSpacesWidth(str, width)
   let right = ""
   let left = ""
   let space = a:width
   let len = strlen(a:str)
   let leftspace = (space - len) / 2
   let rightspace = leftspace
   let c = 0

   if (len % 2 != 0)
      let leftspace += 1
   endif

   while c < rightspace
      let right = right . " "
      let c += 1
   endwhile
   let c = 0
   while c < leftspace
      let left = left . " "
      let c += 1
   endwhile

   return left . a:str . right
endfunction


" -------------------------------------------------------------------------- "
"                            MetaComment SubTypes                            "
" -------------------------------------------------------------------------- "

function! s:MetaCommentC(str)
      exec "normal i/*" . g:MetaComment_header_c
      exec "normal o"
      exec "normal 0d$i " . g:MetaComment_left_c . StringWithWhiteSpaces(a:str) . g:MetaComment_right_c
      exec "normal o"
      exec "normal 0d$i " . g:MetaComment_footer_c . "*/"
endfunction

function! s:MetaCommentCpp(str)
      exec "normal i//" . g:MetaComment_header_cpp
      exec "normal o"
      exec "normal 0d$i//" . g:MetaComment_left_cpp . StringWithWhiteSpaces(a:str) . g:MetaComment_right_cpp
      exec "normal o"
      exec "normal 0d$i//" . g:MetaComment_footer_cpp
endfunction

function! s:MetaCommentSh(str)
      exec "normal i#" . g:MetaComment_header_sh
      exec "normal o"
      exec "normal 0d$i#" . g:MetaComment_left_sh . StringWithWhiteSpaces(a:str) . g:MetaComment_right_sh
      exec "normal o"
      exec "normal 0d$i#" . g:MetaComment_footer_sh
endfunction

function! s:MetaCommentAsm(str)
      exec "normal i;" . g:MetaComment_header_asm
      exec "normal o"
      exec "normal 0d$i;" . g:MetaComment_left_asm . StringWithWhiteSpaces(a:str) . g:MetaComment_right_asm
      exec "normal o"
      exec "normal 0d$i;" . g:MetaComment_footer_asm
endfunction

function! s:MetaCommentVim(str)
      exec "normal i\"" . g:MetaComment_header_vim
      exec "normal o"
      exec "normal 0d$i\"" . g:MetaComment_left_vim . StringWithWhiteSpaces(a:str) . g:MetaComment_right_vim
      exec "normal o"
      exec "normal 0d$i\"" . g:MetaComment_footer_vim
endfunction

function! s:MetaCommentVhdl(str)
      exec "normal i--" . g:MetaComment_header_vhdl
      exec "normal o"
      exec "normal 0d$i--" . g:MetaComment_left_vhdl . StringWithWhiteSpaces(a:str) . g:MetaComment_right_vhdl
      exec "normal o"
      exec "normal 0d$i--" . g:MetaComment_footer_vhdl
endfunction

function! s:MetaCommentLaTeX(str)
      exec "normal i%" . g:MetaComment_header_latex
      exec "normal o"
      exec "normal 0d$i%" . g:MetaComment_left_latex . StringWithWhiteSpaces(a:str) . g:MetaComment_right_latex
      exec "normal o"
      exec "normal 0d$i%" . g:MetaComment_footer_latex
endfunction

function! s:MetaCommentHtml(str)
      exec "normal i<!--" . g:MetaComment_header_html
      exec "normal o"
      exec "normal 0d$i " . g:MetaComment_left_html . StringWithWhiteSpaces(a:str) . g:MetaComment_right_html
      exec "normal o"
      exec "normal 0d$i " . g:MetaComment_footer_html . "-->"
endfunction

function! s:MetaCommentJinja(str)
      exec "normal i{#" . g:MetaComment_header_jinja
      exec "normal o"
      exec "normal 0d$i " . g:MetaComment_left_jinja . StringWithWhiteSpaces(a:str) . g:MetaComment_right_jinja
      exec "normal o"
      exec "normal 0d$i " . g:MetaComment_footer_jinja . "#}"
endfunction



" -------------------------------------------------------------------------- "
"                              Main MetaComment                              "
" -------------------------------------------------------------------------- "

function! s:MetaComment(str)
   let ft = &filetype

   if ft == "c" || ft == "edc" || ft == "js" || ft == "php" || ft == "objc" || ft == "objcpp" || ft == "rust"
               \ || ft == "java"
      call s:MetaCommentC(a:str)
   elseif ft == "cpp"
      call s:MetaCommentCpp(a:str)
   elseif ft == "sh" || ft == "bash" || ft == "zsh" || ft == "ruby" || ft == "python" || ft == "conf"
      call s:MetaCommentSh(a:str)
   elseif ft == "asm"
      call s:MetaCommentAsm(a:str)
   elseif ft == "vim"
      call s:MetaCommentVim(a:str)
   elseif ft == "vhdl"
      call s:MetaCommentVhdl(a:str)
   elseif ft == "tex" || ft == "mat"
      call s:MetaCommentLaTeX(a:str)
   elseif ft == "html"
      call s:MetaCommentHtml(a:str)
   elseif ft == "jinja"
      call s:MetaCommentJinja(a:str)
   else
      echoerr("Unimplemented filetype '" . ft . "'. Please report to jean@guyomarch.bzh or fix it yourself (but then please let me know)")
   endif

endfunction

function! s:MetaHeader(str)
   let ft = &filetype
   " default is C comment style
   let meta_s = '/*'
   let meta_e = ' */'
   let meta_left = ' *'
   let meta_right = ''
   if ft == "c" || ft == "edc" || ft == "js" || ft == "php" || ft == "objc" || ft == "objcpp" || ft == "rust"
               \ || ft == "java"
       "call s:MetaCommentC(a:str)
   elseif ft == "cpp"
      "call s:MetaCommentCpp(a:str)
   elseif ft == "sh" || ft == "bash" || ft == "zsh" || ft == "ruby" || ft == "python" || ft == "conf"
               \ || ft == "make"
       "call s:MetaCommentSh(a:str)
       let meta_s = "#"
       let meta_e = "#"
       let meta_left = "#"
       let meta_right = ""
   elseif ft == "asm"
      "call s:MetaCommentAsm(a:str)
   elseif ft == "vim"
      "call s:MetaCommentVim(a:str)
       let meta_s = '"'
       let meta_e = '"'
       let meta_left = '"'
       let meta_right = ''
   elseif ft == "vhdl"
      "call s:MetaCommentVhdl(a:str)
   elseif ft == "tex" || ft == "mat"
      "call s:MetaCommentLaTeX(a:str)
   elseif ft == "html"
      "call s:MetaCommentHtml(a:str)
   elseif ft == "jinja"
      "call s:MetaCommentJinja(a:str)
   else
      echoerr("Unimplemented filetype '" . ft . "'. Please report to jean@guyomarch.bzh or fix it yourself (but then please let me know)")
   endif
   exec "normal 0,0go"
   exec "normal! O"
   exec "normal! 0d$i" . meta_s
   if g:MetaComment_header_all != ''
       exec "normal! o"
       exec "normal! 0d$i" . meta_left . g:MetaComment_header_all . meta_right
   endif
   exec "normal! o"
   call MultiStringWithMeta(a:str, meta_left, meta_right)
   if g:MetaComment_footer_all != ''
       exec "normal! o"
       exec "normal! 0d$i" . meta_left. g:MetaComment_footer_all . meta_right
   endif
   "exec "normal! o"
   exec "normal! 0d$i" . meta_e
endfunction

"[BUGFIX]-Add-BEGIN by TCTNB.WQF, 2012/7/7, reason
"PR-xxxxx
"[BUGFIX]-Add-END by TCTNB.WQF
"FR-xxxxx
" Add，Mod，Del
" BUGFIX,PLATFORM,BUGFIX
"

if !exists("g:cauthor")
   let g:cauthor='GCSSZ.R&D(chunhua.chen@tcl.com)'
   "let g:cauthor='R&D1.(tbd@tbd)'
   let s:cauthor =  substitute(g:cauthor, ".*(", "", "")
   let s:cmail =  substitute(s:cauthor, ")", "", "")
   let s:cauthor =  substitute(s:cauthor, "@.*", "", "")
else
   let s:cauthor =  substitute(g:cauthor, ".*(", "", "")
   let s:cmail =  substitute(s:cauthor, ")", "", "")
   let s:cauthor =  substitute(s:cauthor, "@.*", "", "")
endif

if !exists("g:ctask")
   let g:ctask = "TBD"
endif

if !exists("g:cfeature")
    let g:cfeature = "TBD"
endif

if !exists("g:cheader")
   let g:cheader ="" . "
               \Date: " . strftime("%m/%Y") . " \n
               \                                PRESENTATION\n
               \
               \       Copyright 2017 TCL Communication Technology Holdings Limited.\n
               \
               \ This material is company confidential, cannot be reproduced in any form\n
               \ without the written permission of TCL Communication Technology Holdings\n
               \ Limited.\n
               \\n
               \\n
               \  Author :  " . s:cauthor . "\n
               \  Email  :  " . s:cmail . "\n
               \  Role   :
               \  Reference documents :\n
               \  Comments :\n
               \  File     :\n
               \  Labels   :\n
               \\n
               \ --------------------------------------------------------------------------\n
               \ ==========================================================================\n
               \     Modifications on Features list / Changes Request / Problems Report\n
               \ --------------------------------------------------------------------------\n
               \    date   |        author        |         Key          |     comment\n
               \ ----------|----------------------|----------------------|-----------------\n
               \ " . "
               \" . StringWithWhiteSpacesWidth(strftime('%d/%m/%Y'), 10) . "|
               \" . StringWithWhiteSpacesWidth(s:cauthor, 22) . "|
               \" . StringWithWhiteSpacesWidth("TASK " . g:ctask, 22) . "|
               \" . StringWithWhiteSpacesWidth(g:cfeature, 17) . "\n
               \ ----------|----------------------|----------------------|-----------------\n
               \"
endif

fun! CompleteAuthorAnchor(findstart, base)
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
    " find months matching with "a:base"
    let l:curtime=strftime("%m/%d/%Y")
    "[BUGFIX]-Add-BEGIN by TCTNB.WQF, 2012/7/7, reason
    let res = []
    for m in ['BUGFIX]', 'PLATFORM]', 'FEATURE]']
      if m =~ '^' . a:base
        for suffix in ['-Add', '-Mod', '-Del']
	      call add(res, m . suffix . '-BEGIN by ' . g:cauthor . ',' . l:curtime . ',' . 'TASK-' . g:ctask)
          call add(res, m . suffix . '-END by '. g:cauthor)
        endfor
      endif
    endfor
    return res
  endif
endfun
set completefunc=CompleteAuthorAnchor

" -------------------------------------------------------------------------- "
"                                 Public API                                 "
" -------------------------------------------------------------------------- "

command! -nargs=0 MetaHeader call s:MetaHeader(g:cheader)
command! -nargs=1 MetaComment call s:MetaComment(<f-args>)
"command! -nargs=1 MetaCommentC call s:MetaCommentC(<f-args>)
"command! -nargs=1 MetaCommentCpp call s:MetaCommentCpp(<f-args>)
"command! -nargs=1 MetaCommentSh call s:MetaCommentSh(<f-args>)
"command! -nargs=1 MetaCommentAsm call s:MetaCommentAsm(<f-args>)
"command! -nargs=1 MetaCommentVim call s:MetaCommentVim(<f-args>)
"command! -nargs=1 MetaCommentVhdl call s:MetaCommentVhdl(<f-args>)
"command! -nargs=1 MetaCommentLaTeX call s:MetaCommentLaTeX(<f-args>)
"command! -nargs=1 MetaCommentHtml call s:MetaCommentHtml(<f-args>)

" EOF
