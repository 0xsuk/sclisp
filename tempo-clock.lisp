(in-package :sclisp)
(named-readtables:in-readtable :sc)

(defsynth fm-synth ((freq 440) (dur 1) (indx 1) (gain 1) (out 0))
  (-<> (line.kr (* gain .2) 0 dur :act :free)
       (pm-osc.ar freq (* freq 1) indx 0 (* 1 .2) <>)
       (out.ar out <>))
  )

(defsynth sample-play ((bufnum 0) (gain 1) (rev .0))
  (let ((sig (-<> (buf-rate-scale.ir bufnum)
                  (play-buf.ar 2 bufnum <> :act :free)
                  (* gain <>)
                  )))
    (out.ar 0 sig)
    (out.ar 60 (* rev sig)))
  )

(proxy :reverb
       (g-verb.ar (in.ar 60 2) 100 8.0)
       :pos :tail)

(defvar *root* 0)

(clock-bpm 170)

(defvar *hihat* (buffer-read "./sample/hihat.aif"))
(defvar *kick* (buffer-read "~/music/Kick-808.aif"))
(defvar *snare* (buffer-read "~/music/Snare-909-Tune8-s.wav"))

(defun fm-key (beat)
  (at-beat beat
    (synth 'fm-synth :freq (midicps 41) :gain .001 :dur (clock-dur 2))
    ;; (dolist (note (pc:make-chord 40 80 4 (pc:chord *root* :^7)))
    ;; (synth 'fm-synth :freq (midicps note) :gain .001 :dur (clock-dur 2))
    ;; (synth 'fm-synth :freq (+ 2 (midicps note)) :gain .001 :dur (clock-dur 2))
    ;; )
    )
  (clock-add (+ beat 1) 'fm-key (+ beat 1)))

(fm-key (clock-quant 1))

(defsynth kick ()
  (-<> (env-gen.kr (perc 0 0.13 1 -8) :act :free)
       (* 4 <>)
       (+ 1 <>)
       (* 55 <> (x-line.ar 1 0.5 1))
       (sin-osc.ar <>)
       (+ <> (-<> (env-gen.kr (perc 0.0001 0.01) :act :free)
                  (* (x-line.ar 4000 50 0.01) <> (dbamp -5))
                  (sin-osc.ar <>)
                  ))
       (+ <> (-<> (bpf.ar (hasher.ar (sweep.ar)) 10120 0.5)
                  (* <> (env-gen.kr (perc 0.001 0.03)) (dbamp -8))))
       )
  )

(defsynth drum80s ()
  (-<> (env-gen.kr (perc 0.01 0.3) :gate 1 :act :free)
       (* 0.5 <>)
       (white-noise.ar <>)
       (resonz.ar <> 200 0.3)
       (g-verb.ar <> 10 3 0.5 15 1 0.7 0.5 300)
       (out.ar 0 <>)))

(defun test (beat dur i)
  (at-beat beat (synth 'sample-play :bufnum *hihat* :gain 0.3))
  (when (find (mod i 8) '(0 2 5 6))
    (at-beat beat (synth 'sample-play :bufnum *kick* :gain 1)))
  (let ((next (+ beat dur)))
    (clock-add next 'test next dur (+ i 1)))
  )

(defun drum-kit (beat dur i)
  (at-beat beat (synth 'sample-play :bufnum *hihat* :gain
                       (if (= 0 (mod i 64)) 2 1)))
  (when (find (mod i 8) '(0 4))
    (at-beat beat (synth 'sample-play :bufnum *kick* :gain .2)))
  (when (find (mod i 8) '(2 6))
    (at-beat beat (synth 'sample-play :bufnum *snare* :gain .1)))
  ;; (alexandria:when-let ((pos (find (mod i 16) '(4 12))))
  ;; (at-beat beat (synth 'sample-play :bufnum *snare* :gain 1 :rev (if (= pos 12) .1 .0))))
  (let ((next (+ beat dur)))
    (clock-add next 'drum-kit next dur (+ i 1))))

(drum-kit (clock-quant 1) 1/4 0)

(defsynth disk_writer ((out_buf_num 99))
  (disk-out.ar out_buf_num (in.ar 0)))
(setf mybuffer (buffer-alloc (expt 2 17)))
(setf writer_0 (synth 'disk_writer))
(ctrl writer_0 :out_buf_num (bufnum mybuffer))
(buffer-write mybuffer "/tmp/foo.aiff" :leave-open-p t)
(buffer-close mybuffer)
(buffer-free mybuffer)
