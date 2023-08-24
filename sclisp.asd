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
               (:file "util")
               (:module "sound"
                :components        
                #.(loop for file in (directory "sound/*.lisp")
                        collect `(:file ,(pathname-name file))))))
