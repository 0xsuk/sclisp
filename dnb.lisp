(in-package :sclisp)
(named-readtables:in-readtable :sc)


(clock-bpm 170)

(defsynth fm-synth ((freq 440) (dur 1) (indx 1) (amp (dbamp -5)) (out 0))
  (flow
    (x-line.kr 1 .01 (- dur .01) :act :free)
    (pm-osc.ar freq freq indx 0 <>)
    (* amp .5)
    (draw <> :frames 48000)
    (out.ar out))
  )

(defparameter *octave* 12)
(defparameter *2octave* 24)
(defparameter *3octave* 36)
(defparameter *midi-c* 72)
(defparameter *midi-c#* 73)
(defparameter *midi-db* 73)
(defparameter *midi-d* 74)
(defparameter *midi-d#* 75)
(defparameter *midi-eb* 75)
(defparameter *midi-e* 76)
(defparameter *midi-f* 77)
(defparameter *midi-f#* 78)
(defparameter *midi-gb* 78)
(defparameter *midi-g* 79)
(defparameter *midi-g#* 80)
(defparameter *midi-ab* 80)
(defparameter *midi-a* 81)
(defparameter *midi-bb* 82)
(defparameter *midi-b* 83)

(defun fm (beat dur i)
  (flow
    (mod i 32) :as i32
    (list *midi-f* (+ *octave* *midi-c*) *midi-bb* *midi-f* *midi-bb* (+ *octave* *midi-c*) (+ *octave* *midi-d*) (+ *octave* *midi-c*) *midi-bb* (+ *octave* *midi-c*)) :as notes
    (position i32 '(0 4 8 12 20 22 24 26 28 30)) :as position
    (when position
      (at-beat beat
        (synth 'fm-synth :freq (midicps (nth position notes)) :dur (clock-dur 3))))
    )
  (flow
    (+ beat dur) :as next
    (clock-add next 'fm next dur (+ i 1)))
  )

(defun ja--n (beat dur i)
  (flow
    (mod i 16) :as i16
    (list (- *midi-g* *2octave*) (- *midi-bb* *2octave*) (- *midi-c* *octave*) (- *midi-bb* *2octave*)) :as notes
    (position i16 '(0 3 8 11)) :as position
    (when position
      (at-beat beat
        (synth 'fm-synth :freq (midicps (nth position notes)) :dur (clock-dur 8) :indx -1))))
  (flow
    (+ beat dur) :as next
    (clock-add next 'ja--n next dur (+ i 1))))

(defun dnb (beat dur i)
  (when (find (mod i 16) '(0 6 10))
    (at-beat beat (synth 'kick2)))
  (when (find (mod i 16) '(4 12))
    (at-beat beat (synth 'snare :att .001 :rel .15 :freq 100)))
  (let ((next (+ beat dur)))
    (clock-add next 'dnb next dur (+ i 1))))

;; (dnb (clock-quant 1) 1/4 0)
