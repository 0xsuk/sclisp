(asdf:defsystem :sclisp
  :name "sclisp"
  :description "https://nunotrocado.com/software/cl-collider-tutorial-1.html"
  :depends-on (
               :cl-arrows
               :losh
               :iterate
							 :cl-collider
               )
  :serial t
  :components ((:file "package")
							 (:file "main")
               )
  )
