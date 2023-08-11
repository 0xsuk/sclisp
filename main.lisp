(in-package :sc-user)
(named-readtables:in-readtable :sc)
(setf *s* (make-external-server "localhost" :port 48800))
(server-boot *s*)
(jack-connect)

(defvar *synth*)
(setf *synth* (play (sin-osc.ar [320 100 400] 0 1)))


(defsynth sine-wave ((note 60))
  (let* ((freq (midicps note))
         (sig (sin-osc.ar [freq (+ freq 1)] 0 0.2)))
		(out.ar 0 sig)))

(setf *synth* (synth 'sine-wave))
(ctrl *synth* :note 72)
(free *synth*)
