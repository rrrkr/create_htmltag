; html属性を作る関数
; (attr 'char-set 'utf-8) => char-set="utf-8"
(defun attr (pair)
  (format t " ~a=\"~a\"" (string-downcase (car pair)) (cdr pair)))

; リストから１対１のペアを作る関数
; (pairs '(a b c d e f)) => ((a . b) (c . d) (e . f))
(defun pairs (lis)
  (cond ((null lis) nil)
	((atom lis) (car lis))
	(t (cons (cons (car lis) (cadr lis)) (pairs (cddr lis))))))

; タグを一つ作る関数
; (print-tag 'meta '(char-set "utf-8") nil) => <meta char-set="utf-8">
; (print-tag 'html nil t) => </html>
(defun print-tag (name alst closep)
  (princ #\<)
  (when closep
    (princ #\/))
  (princ (string-downcase name))
  (mapc #'attr alst)
  (princ #\>))

; タグを作るマクロ
;(tag mytag (color 'blue height (+ 4 5))) => <mytag color="blue" height="9"></mytag>
(defmacro tag (name atts &rest forms)
  `(progn (print-tag ',name
		     (list ,@(mapcar (lambda (x)
				       `(cons ',(car x) ,(cdr x)))
				     (pairs atts)))
		     nil)
	  ,@forms
	  (print-tag ',name nil t)))

(defparameter *filename* "test.html")

; htmlタグのマクロ
; (html) => <html></html>
(defmacro html (&rest forms)
  `(with-open-file (*standard-output* *filename*
										:direction :output
										:if-exists :supersede)
	(tag html ()
	,@forms)))

; headタグのマクロ
; (head) => <head></head>
(defmacro head (&rest forms)
  `(tag head ()
	,@forms))

; bodyタグのマクロ
; (body) => <body></body>
(defmacro body (&rest forms)
  `(tag body ()
	,@forms))


