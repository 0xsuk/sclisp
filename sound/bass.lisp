(in-package :sclisp)
(named-readtables:in-readtable :sc)

(defsynth sawbass ((freq (midicps 35)))
  (flow
    (env '(0 1 0)
         '(.001 2)
         '(3 -1))
    (env-gen.kr <> :act :free) :as env
    (saw.ar freq .5)
    (rlpf.ar <> 350)
    (* env)
    ;; (comb-c.ar <> 1 .125)
    ;; (draw <> :sec 1)
    (out.ar [0 1])))

