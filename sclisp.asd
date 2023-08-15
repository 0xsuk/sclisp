(asdf:defsystem :sclisp
	:name "sclisp"
	:depends-on (
							 :cl-arrows
							 :cl-collider
							 :iterate
							 :sc-extensions
							 :vgplot)
	:serial t
	:components ((:file "package")
							 (:file "setup")
							 (:file "util")))
