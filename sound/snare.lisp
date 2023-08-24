(in-package :sclisp)
(named-readtables:in-readtable :sc)

(defsynth snare ((att .01) (rel .2) (freq 2000) (amp (dbamp -5)))
  (flow
   (env-gen.kr (perc att rel amp) :act :free)
   (hpf.ar (white-noise.ar) freq <>)
   ;; (draw)
   (out.ar 0)
   ))
