(in-package :sclisp)

(defun buffer-plot (buffer &key (bin-width 64) (sample-rate 48000))
  (vgplot:axis (list 0 (/ sample-rate bin-width)
                     -1 1))
  (vgplot:plot (loop for x in (buffer-to-list buffer)
                     for i from 0
                     when (zerop (mod i bin-width))
                       collect x)))

(defmacro plot (ugen)
	`(progn
		 (proxy :plot (* 0 (buf-wr.ar ,ugen *b* (line.ar 0 (buf-frames.kr *b*) +plot-dur+ :act :free))))
		 (buffer-plot *b*))
	)

(defconstant +plot-dur+ 3)
(defconstant +sample-rate+ 48000)
(defvar *b* (buffer-alloc (* +plot-dur+ +sample-rate+)))
