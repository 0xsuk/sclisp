(in-package :sclisp)
(setf *s* (make-external-server "localhost" :port 48800))
(server-boot *s*)
(jack-connect)
