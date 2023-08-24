(in-package :sclisp)
(named-readtables:in-readtable :sc)

(defsynth clap ()
  (flow
    (env
     '(0 1 0 .9 0 .7 0 .5 0)
     '(.001 .009 0 .008 0 .01 0 .03)
     '(0 -3 0 -3 0 -3 0 -4))
    (env-gen.ar)
    (white-noise.ar)
    (hpf.ar <> 600)
    (lpf.ar <> (x-line.kr 7200 4000 .03))
    (bpf.ar <> 1620 3) :as noise1

    (env
     '(0 1 0)
     '(.02 .18)
     '(0 -4))
    (env-gen.ar <> :act :free)
    (white-noise.ar)
    (hpf.ar <> 1000)
    (lpf.ar <> 7600)
    (bpf.ar <> 1230 .7 .7) :as noise2
    
    (+ noise1 noise2)
    (* 2)
    (softclip)
    (draw)
    (out.ar 0)
    )
  )
