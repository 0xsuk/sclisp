(in-package :sclisp)
(named-readtables:in-readtable :sc)

(defsynth kick ((freq 1000) (amp (dbamp -10)))
	(-<> (env `(,freq 50 10)
						'(.01 .2)
						'(1 -1))
			 (env-gen.ar <>)
			 (sin-osc.ar <> (/ pi 2) amp)
			 (* <> (env-gen.kr (env '(0 1 0)
													 '(.01 1)
													 '(1 -15))))
			 (+ <> (* (white-noise.ar .2)
								(env-gen.kr (perc 0.01 .1 .2 10) :act :free)))
			 (draw <> :frames 48000)
			 (out.ar 0 <>)
			 )
	)

(defsynth kick2 ((amp (dbamp -5)))
	(-<>
	 (env-gen.ar (perc 0 0.13 1 -8) :act :free)
	 (+ 1 <>)
	 (* 55 <> (x-line.ar 1 2 1) [1 1.3 3.4 4.8])
	 (sin-osc.ar <>)
	 (* <> (dbamp [0 -10 -5 -8]))
	 (* <> (env-gen.ar (perc [0 .01 .015 .01] [1 .3 .1 .03])))
	 (sum <>)
	 (+ <> (* (dbamp -5)
						(env-gen.ar (perc .0001 .03))
						(sin-osc.ar (x-line.ar 4000 50 .01 ))))
	 (+ <> (* (dbamp -8)
						(env-gen.ar (perc .001 .03))
						(bpf.ar (hasher.ar (sweep.ar)) 8120 .3)))
	 (* <> (+ 1 (* 2 (env-gen.ar (perc .001 .2)))))
	 (tanh <>)
	 (* <> (env-gen.ar (perc .001 1.3 1 -10) :act :free))
	 (* <> amp)
	 (draw <> :frames 48000)
	 (out.ar 0 <>)
	 ))
