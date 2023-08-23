(asdf:defsystem :sclisp
  :name "sclisp"
  :depends-on (
               :cl-arrows
               :cl-collider
               :iterate
               :sc-extensions
               :kai
               :suk)
  :serial t
  :components ((:file "package")
               (:file "setup")
               (:file "util")))
