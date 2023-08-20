(in-package :sclisp)

(defvar *b*)

(defmacro draw (ugen &optional (frames 4800) (mul 0))
	(setf *b* (buffer-alloc frames))
	`(proxy :draw (* ,mul (record-buf.ar ,ugen *b* :loop 0))))

(defun show ()
	(kai:line (buffer-to-list *b*))
	(kai:show))

