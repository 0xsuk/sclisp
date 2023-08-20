(in-package :sclisp)

(defvar *b*)

(defmacro draw (ugen &key (frames 4800) (chanls 1))
	`(progn
		 (setf *b* (buffer-alloc ,frames :chanls ,chanls))
		 (record-buf.ar ,ugen *b* :loop 0)))

(defmacro draw-proxy (ugen &key (frames 4800) (mul 0) (chanls 1))
	`(progn
		 (setf *b* (buffer-alloc ,frames :chanls ,chanls))
		 (proxy :draw (* ,mul (record-buf.ar ,ugen *b* :loop 0)))))

(defun show (&optional chan)
	(let* ((array (buffer-to-array *b*))
				 (nrow (array-dimension array 0))
				 (plot-all-chans-p (and (> nrow 1) (not chan))))
		(if plot-all-chans-p
				(iter:iter
					(iter:for row from 0 below nrow)
					(kai:line (get-nth-row array row))
					(kai:show)
					(format t "~A done" row))
				(progn
					(if chan
							(kai:line (get-nth-row array chan))
							(kai:line (get-nth-row array 0)))
					(kai:show))
				)
		)
	)

(defun get-nth-row (array n)
  (let ((row (make-array (array-dimension array 1))))
    (dotimes (i (array-dimension array 1))
      (setf (aref row i) (aref array n i)))
    row))
