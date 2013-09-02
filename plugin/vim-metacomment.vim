"
" vim-metacomment.vim
"
"
" The MIT License (MIT)
"
" Copyright (c) 2013 Jean Guyomarc'h
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


" -------------
" Configuration
" -------------
if !exists("g:MetaComment_header")
   let g:MetaComment_header = "============================================================================*"
endif

if !exists("g:MetaComment_right")
   let g:MetaComment_right = "*"
endif

if !exists("g:MetaComment_left")
   let g:MetaComment_left = "*"
endif

if !exists("g:MetaComment_footer")
   let g:MetaComment_footer = "============================================================================="
endif


" ----------
" API helper
" ----------
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


" -------------------------
" Public API Implementation
" -------------------------
function! <SID>MetaComment()

   let g:MetaComment = input("Comment: ")

   exec "normal i/*" . g:MetaComment_header
   exec "normal o"
   exec "normal 0d$i " . g:MetaComment_left . StringWithWhiteSpaces(g:MetaComment) . g:MetaComment_right
   exec "normal o"
   exec "normal 0d$i " . g:MetaComment_footer . "*/"

endfunction

" ----------
" Public API
" ----------
command! -nargs=0 MetaComment :call <SID>MetaComment()

" EOF
