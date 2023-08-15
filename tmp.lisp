(in-package :sclisp)
(server-status *s*)



(proxy )

(defsynth z ()
	(-<> (lf-noise0.kr 8)
			 (range <> 200 1000)
			 (sin-osc.ar <>))
	)


(defsynth tmp ()
	(-<> (lf-noise0.ar 1)
			 (d-poll 1 )))

(defsynth newsynth ((gate 1) (freq 440) (amp 0.5) (pan 0) (out 0))
  (let* ((env (env-gen.kr (adsr 0.001 0.1 0.5 0.1) :gate gate :act :free))
         (sig (saw.ar freq)))
    (out.ar out (pan2.ar sig pan (* amp env)))))

(defsynth drum ((freq 3000))
  (let* ((env (* freq (env-gen.ar (perc 0.1 0.1) :act :free)))
         (sig (lpf.ar (white-noise.ar) env)))
    (out.ar 0 (pan2.ar sig 0 0.2))))
