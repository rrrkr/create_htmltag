# create_htmltag

lispのS式でhtmlタグを作成


# DEMO
```
bash$ ls
html.lisp

bash$ clisp

; lisp環境
> (require "html.lisp")
> (html
    (head
      (tag meta (charset 'utf-8))
      (body
        (princ "Hello,World"))))
      
> T

bash$ ls
html.lisp  test.html

bash$ cat test.html
<html><head><meta charset="utf-8"></meta><body>Hello,World</body></head></html>
```
