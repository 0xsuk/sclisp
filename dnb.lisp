(in-package :sclisp)
(named-readtables:in-readtable :sc)


(clock-bpm 170)

(fm-key (clock-quant 1))

(defun fm (beat dur i)
  (at-beat beat
    (synth 'fm-synth :freq (midicps 41)))
  (let ((next (+ beat dur)))
    (clock-add next 'fm next dur (+ i 1))))

(defun dnb (beat dur i)
  ;; (at-beat beat
  ;; (synth 'fm-synth :freq
  ;; (midicps 41) :dur 1 :out 1))
  (when (find (mod i 16) '(0 10))
    (at-beat beat (synth 'kick2 :amp (dbamp -6))))
  (when (find (mod i 16) '(4 12))
    (at-beat beat (synth 'snare :att .001 :rel .15 :freq 100)))
  (let ((next (+ beat dur)))
    (clock-add next 'dnb next dur (+ i 1))))

(dnb (clock-quant 1) 1/4 0)
