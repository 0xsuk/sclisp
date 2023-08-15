(in-package :sclisp)
(named-readtables:in-readtable :sc)
(setf *s* (make-external-server "localhost" :port 48800))
(server-boot *s*)
(jack-connect)

(defsynth fm-synth ((freq 440) (ratio 1.0) (indx 1.0) (dur 1.0) (gain 1.0) (pan 0.0))
	(-<> (line.kr (* gain .2) .0 dur :act :free)
			 (pm-osc.ar (* freq ratio) indx 0 <>)
			 (pan2.ar <> pan)
			 (out.ar 0 <>))
	)

(defun fm-key (beat)
	(at-beat beat 
		(iter:iter (iter:for note in (pc:make-chord 40 80 4 (pc:chord 0 :^7)))
			(synth 'fm-synth :freq (midicps note) :gain .4 :dur (clock-dur 2) :pan -1.0)))
	(at-beat beat 
		(synth 'fm-synth))
	(clock-add (+ beat 1) 'fm-key (+ beat 1)))

(fm-key (clock-quant 4))
